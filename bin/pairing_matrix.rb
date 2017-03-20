require_relative '../lib/pairing_matrix'

config_reader = PairingMatrix::ConfigReader.new('pairing_matrix.yml')
config = config_reader.config
commit_reader = PairingMatrix::CommitReader.new(config)
p commit_reader.authors('2017-02-26')