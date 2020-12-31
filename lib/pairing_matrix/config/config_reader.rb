require 'yaml'
require_relative 'config'
require_relative 'public_repos'
require_relative 'private_repos'

module PairingMatrix
  class ConfigReader
    def initialize(config_file)
      @config_file = config_file
    end

    def config
      raw_config = YAML::load_file @config_file

      PairingMatrix::Config.new(
        raw_config['authors_regex'],
        PairingMatrix::PublicRepos.create_from(raw_config['local']),
        PairingMatrix::PrivateRepos.create_from(raw_config['gitlab']),
        PairingMatrix::PrivateRepos.create_from(raw_config['github'])
       )
    end
  end
end