require 'YAML'

module PairingMatrix
  class ConfigReader
    def initialize(config_file)
      @config_file = config_file
    end

    def config
      raw_config = YAML::load_file @config_file
      PairingMatrix::Config.new(raw_config['repos'], raw_config['authors_regex'])
    end
  end
end