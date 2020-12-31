require 'sinatra/base'
require 'puma'
require 'json'
require_relative '../../pairing_matrix'
require_relative '../config/config_reader'
require_relative '../cache/commit_cache'
require_relative '../commit_readers/local_commit_reader'
require_relative '../commit_readers/github_commit_reader'
require_relative '../commit_readers/gitlab_commit_reader'

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

    local_commit_reader = PairingMatrix::LocalCommitReader.new(config)
    github_commit_reader = PairingMatrix::GithubCommitReader.new(config)
    gitlab_commit_reader = PairingMatrix::GitlabCommitReader.new(config)

    get '/data/:days' do
      PairingMatrix.enable_caching = params[:cache_enabled] != 'false'

      local_data = local_commit_reader.authors_with_commits(params['days'].to_i)
      github_data = github_commit_reader.authors_with_commits(params['days'].to_i)
      gitlab_data = gitlab_commit_reader.authors_with_commits(params['days'].to_i)

      (local_data + github_data + gitlab_data).to_json
    end

    get '/matrix' do
      File.read(File.join(File.dirname(__FILE__), 'public/index.html'))
    end

    get '/' do
      redirect '/matrix'
    end
  end
end
