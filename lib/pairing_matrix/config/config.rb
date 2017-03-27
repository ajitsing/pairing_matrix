module PairingMatrix
  class Config
    attr_reader :repos, :authors_regex, :github_access_token, :github_repos

    def initialize(repos, authors_regex, github_access_token, github_repos)
      @repos = repos
      @authors_regex = authors_regex
      @github_access_token = github_access_token
      @github_repos = github_repos
    end

    def has_github_repo?(repo)
      @github_repos.include? repo
    end
  end
end