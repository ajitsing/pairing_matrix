module PairingMatrix
    class PrivateRepos
        attr_reader :repositories, :access_token, :url

        def initialize(repos, access_token, url)
            @repositories = repos
            @access_token = access_token
            @url = url
        end

        def self.create_from(config)
            repos = config['repositories'] rescue []
            access_token = config['access_token'] rescue nil
            url = config['url'] || 'https://api.github.com/' rescue nil

            PrivateRepos.new(repos, access_token, url)
        end

        def has_github_access_token?
            !@access_token.nil? && !@access_token.empty?
        end

        def present?
            !@repositories.nil? && !@repositories.empty?
        end
    end
end