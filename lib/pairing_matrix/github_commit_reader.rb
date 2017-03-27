require 'octokit'

Octokit.auto_paginate = true

module PairingMatrix
  class GithubCommitReader < CommitReader
    def initialize(config)
      super(config)
      @repos = nil
      @github_client = Octokit::Client.new(:access_token => @config.github_access_token)
    end

    def read(since)
      repos.map do |repo|
        puts "Fetching commits since #{since} for #{repo}"
        commits = @github_client.commits_since(repo, since).map { |commit| commit.commit.message }
        puts "Total commits: #{commits.size}"
        commits
      end.flatten
    end

    private
    def repos
      return @repos unless @repos.nil?
      repos = @github_client.repos.map { |repo| repo.name }
      orgs = @github_client.orgs.map { |org| org.login }
      orgs.each do |org|
        repos << @github_client.org_repos(org).map { |repo| "#{org}/#{repo.name}" }
      end

      @repos = repos.flatten.select { |repo| @config.has_github_repo? repo }
      p @repos
    end
  end
end