module PairingMatrix
  class Config
    attr_reader :repos

    def initialize(repos)
      @repos = repos
    end
  end
end