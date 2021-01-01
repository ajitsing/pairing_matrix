module PairingMatrix
  class Config
    attr_reader :authors_regex, :local, :gitlab, :github

    def initialize(local, gitlab, github)
      @local = local
      @gitlab = gitlab
      @github = github
    end
  end
end
