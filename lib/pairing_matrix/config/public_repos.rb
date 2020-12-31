module PairingMatrix
    class PublicRepos
        attr_reader :repositories, :url

        def initialize(repos)
            @repositories = repos
        end

        def self.create_from(config)
            repos = config['repositories'] rescue []
            PublicRepos.new(repos)
        end
    end
end