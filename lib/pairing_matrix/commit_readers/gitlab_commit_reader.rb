require 'gitlab'
require 'eldritch'
require_relative '../cache/commit_cache'
require_relative './commit_reader'

module PairingMatrix
  class GitlabCommitReader < CommitReader
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
            client = gitlab_client(@config.gitlab)
            @config.gitlab.repositories.map do |repo|
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
        client.commits(repo, since: since).map { |commit| commit.title }
    end

    def gitlab_client(gitlab_config)
        Gitlab.client(endpoint: gitlab_config.url, private_token: gitlab_config.access_token)
    end
  end
end