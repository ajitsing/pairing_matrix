module PairingMatrix
  class Config
    attr_reader :authors_regex, :local_repositories, :github_public_repositories, :github_private_repositories, :github_enterprise_repositories

    def initialize(authors_regex, local_repositories, github_public_repositories, github_private_repositories, github_enterprise_repositories)
      @authors_regex = authors_regex
      @local_repositories = local_repositories
      @github_public_repositories = github_public_repositories
      @github_private_repositories = github_private_repositories
      @github_enterprise_repositories = github_enterprise_repositories
    end

    def fetch_from_github?
      [
        @github_public_repositories,
        @github_private_repositories,
        @github_enterprise_repositories
      ].any?(&:present?)
    end

    def has_github_access_token?
      @github_private_repositories.has_github_access_token?
    end

    def github_enterprise?
      @github_private_repositories.github_enterprise?
    end
  end
end
