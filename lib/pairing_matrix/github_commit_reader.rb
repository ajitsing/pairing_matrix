require 'octokit'
require 'eldritch'

Octokit.auto_paginate = true

module PairingMatrix
  class GithubCommitReader < CommitReader
    def initialize(config)
      super(config)
      @github_client = github_client
    end

    def read(since)
      commits = []
      together do
        @config.github_repos.map do |repo|
          async do
            commits << fetch_commits(repo, since)
          end
        end
      end
      commits.flatten
    end

    private
    def fetch_commits(repo, since)
      puts "Fetching commits since #{since} for #{repo}"
      commits = @github_client.commits_since(repo, since).map { |commit| commit.commit.message }
      puts "Total commits: #{commits.size}"
      commits
    end

    def github_client
      if @config.has_github_access_token?
        Octokit::Client.new(:access_token => @config.github_access_token)
      else
        Octokit::Client.new
      end
    end
  end
end