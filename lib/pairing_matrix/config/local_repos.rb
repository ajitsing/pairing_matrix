module PairingMatrix
    class LocalRepos
        attr_reader :repositories, :url, :authors_regex

        def initialize(authors_regex, repos)
            @repositories = repos
            @authors_regex = authors_regex
        end

        def self.create_from(authors_regex, config)
            repos = config['repositories'] rescue []
            LocalRepos.new(authors_regex, repos)
        end

        def absent?
            @repositories.empty?
        end
    end
end