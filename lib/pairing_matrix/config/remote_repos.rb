module PairingMatrix
    class RemoteRepos
        attr_reader :repositories, :access_token, :url, :authors_regex

        def initialize(authors_regex, repos, access_token, url)
            @url = url
            @repositories = repos
            @authors_regex = authors_regex
            @access_token = access_token
        end

        def self.create_from(authors_regex, config)
            repos = config['repositories'] rescue []
            access_token = config['access_token'] rescue nil
            url = config['url'] rescue nil

            RemoteRepos.new(authors_regex, repos, access_token, url)
        end

        def has_access_token?
            !@access_token.nil? && !@access_token.empty?
        end

        def absent?
            @repositories.empty?
        end
    end
end