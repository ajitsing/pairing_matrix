require 'octokit'
require 'eldritch'
require_relative '../cache/commit_cache'
require_relative './commit_reader'

Octokit.auto_paginate = true

module PairingMatrix
  class GithubCommitReader < CommitReader
    def initialize(config)
      super(config)
      @cache = CommitCache.new
    end

    protected
    def read(since)
      cache = @cache.get(since)
      return cache unless cache.nil?

      commits = []
      together do
        [
          @config.github_public_repositories,
          @config.github_private_repositories,
          @config.github_enterprise_repositories
        ].each do |github_repos|
          client = github_client(github_repos)

          github_repos.repositories.map do |repo|
            async do
              commits << fetch_commits(client, repo, since)
            end
          end
        end
      end

      result = commits.flatten
      @cache.put(since, result)
      result
    end

    private
    def fetch_commits(client, repo, since)
      client.commits_since(repo, since).map { |commit| commit.commit.message }
    end

    def github_client(github_config)
      Octokit.configure {|c| c.api_endpoint = github_config.url} if github_config.url

      if github_config.has_github_access_token?
        Octokit::Client.new(:access_token => github_config.access_token)
      else
        Octokit::Client.new
      end
    end
  end
end