module PairingMatrix
  class Config
    attr_reader :repos, :authors_regex, :github_access_token, :github_repos

    def initialize(repos, authors_regex, github_access_token, github_repos)
      @repos = repos
      @authors_regex = authors_regex
      @github_access_token = github_access_token
      @github_repos = github_repos
    end

    def fetch_from_github?
      !@github_repos.nil? && !@github_repos.empty?
    end

    def has_github_access_token?
      !@github_access_token.nil? && !@github_access_token.empty?
    end
  end
end