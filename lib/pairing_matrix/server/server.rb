require 'sinatra/base'
require 'json'
require_relative '../../pairing_matrix'
require_relative '../config/config_reader'
require_relative '../commit_reader'
require_relative '../github_commit_reader'

module PairingMatrix
  class Server < Sinatra::Base
    set :bind, '0.0.0.0'

    config_reader = PairingMatrix::ConfigReader.new('pairing_matrix.yml')
    config = config_reader.config
    commit_reader = PairingMatrix::CommitReader.new(config)
    commit_reader = PairingMatrix::GithubCommitReader.new(config) if config.fetch_from_github?

    get '/data/:days' do
      commit_reader.authors_with_commits(params['days'].to_i).to_json
    end

    get '/matrix' do
      File.read(File.join(File.dirname(__FILE__), 'public/index.html'))
    end
  end
end