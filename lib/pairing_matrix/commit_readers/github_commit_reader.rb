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
        client = github_client

        @config.repositories.map do |repo|
          async do
            commits << fetch_commits(client, repo, since)
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

    def github_client
      Octokit.configure {|c| c.api_endpoint = @config.url}

      if @config.has_access_token?
        Octokit::Client.new(:access_token => @config.access_token)
      else
        Octokit::Client.new
      end
    end
  end
end