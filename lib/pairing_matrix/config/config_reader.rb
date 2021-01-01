require 'yaml'
require_relative 'config'
require_relative 'local_repos'
require_relative 'remote_repos'

module PairingMatrix
  class ConfigReader
    def initialize(config_file)
      @config_file = config_file
    end

    def config
      raw_config = YAML::load_file @config_file
      author_regex = raw_config['authors_regex']

      PairingMatrix::Config.new(
        PairingMatrix::LocalRepos.create_from(author_regex, raw_config['local']),
        PairingMatrix::RemoteRepos.create_from(author_regex, raw_config['gitlab']),
        PairingMatrix::RemoteRepos.create_from(author_regex, raw_config['github'])
       )
    end
  end
end