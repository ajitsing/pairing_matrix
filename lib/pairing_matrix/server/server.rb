require 'sinatra/base'
require 'puma'
require 'json'
require_relative '../../pairing_matrix'
require_relative '../config/config_reader'
require_relative '../commit_reader'
require_relative '../commit_cache'
require_relative '../github_commit_reader'

module PairingMatrix
  class Server < Sinatra::Base
    set :bind, '0.0.0.0'
    set :server, :puma

    logging_file = File.new('app.log', 'a+')
    logging_file.sync = true
    before {
      env["rack.errors"] = logging_file
    }
    configure do
      enable :logging
      logging_file.sync = true
      use Rack::CommonLogger, logging_file
    end

    PairingMatrix.enable_caching = true
    config_reader = PairingMatrix::ConfigReader.new('pairing_matrix.yml')
    config = config_reader.config
    commit_reader = PairingMatrix::CommitReader.new(config)
    commit_reader = PairingMatrix::GithubCommitReader.new(config) if config.fetch_from_github?

    get '/data/:days' do
      PairingMatrix.enable_caching = params[:cache_enabled] != 'false'
      commit_reader.authors_with_commits(params['days'].to_i).to_json
    end

    get '/matrix' do
      File.read(File.join(File.dirname(__FILE__), 'public/index.html'))
    end

    get '/' do
      redirect '/matrix'
    end
  end
end
