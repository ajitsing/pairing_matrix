require_relative '../lib/pairing_matrix'

config_reader = PairingMatrix::ConfigReader.new('pairing_matrix.yml')
commit_reader = PairingMatrix::CommitReader.new(config_reader.config.repos)
p commit_reader.read('2017-02-26')