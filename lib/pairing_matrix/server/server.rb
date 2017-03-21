require 'sinatra'
require 'json'
require_relative '../../pairing_matrix'

config_reader = PairingMatrix::ConfigReader.new('pairing_matrix.yml')
config = config_reader.config
commit_reader = PairingMatrix::CommitReader.new(config)

get '/data/:days' do
  commit_reader.authors_with_commits(params['days'].to_i).to_json
end

get '/matrix' do
  File.read(File.join('lib/pairing_matrix/server/public', 'index.html'))
end