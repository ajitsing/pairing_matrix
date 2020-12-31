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

        def present?
            !@repositories.nil? && !@repositories.empty?
        end

        def has_github_access_token?
            false
        end

        def url
            'https://api.github.com/'
        end

        def github_enterprise?
            false
        end
    end
end