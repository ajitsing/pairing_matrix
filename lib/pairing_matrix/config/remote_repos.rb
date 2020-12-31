module PairingMatrix
    class RemoteRepos
        attr_reader :repositories, :access_token, :url

        def initialize(repos, access_token, url)
            @repositories = repos
            @access_token = access_token
            @url = url
        end

        def self.create_from(config)
            repos = config['repositories'] rescue []
            access_token = config['access_token'] rescue nil
            url = config['url'] rescue nil

            RemoteRepos.new(repos, access_token, url)
        end

        def has_access_token?
            !@access_token.nil? && !@access_token.empty?
        end

        def absent?
            @repositories.empty?
        end
    end
end