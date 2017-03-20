module PairingMatrix
  class Config
    attr_reader :repos, :authors_regex

    def initialize(repos, authors_regex)
      @repos = repos
      @authors_regex = authors_regex
    end
  end
end