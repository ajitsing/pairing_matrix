module PairingMatrix
  class Config
    attr_reader :authors_regex, :local, :gitlab, :github

    def initialize(authors_regex, local, gitlab, github)
      @authors_regex = authors_regex
      @local = local
      @gitlab = gitlab
      @github = github
    end

    def has_github_access_token?
      @github.has_github_access_token?
    end
  end
end
