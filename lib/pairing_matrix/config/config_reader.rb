require 'yaml'
require_relative 'config'

module PairingMatrix
  class ConfigReader
    def initialize(config_file)
      @config_file = config_file
    end

    def config
      raw_config = YAML::load_file @config_file
      PairingMatrix::Config.new(
          raw_config['repos'],
          raw_config['authors_regex'],
          raw_config['github_access_token'],
          raw_config['github_repos'],
          raw_config['github_url']
      )
    end
  end
end