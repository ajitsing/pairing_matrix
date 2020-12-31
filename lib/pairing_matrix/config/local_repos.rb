module PairingMatrix
    class LocalRepos
        attr_reader :repositories, :url

        def initialize(repos)
            @repositories = repos
        end

        def self.create_from(config)
            repos = config['repositories'] rescue []
            LocalRepos.new(repos)
        end

        def absent?
            @repositories.empty?
        end
    end
end