require 'date'
require_relative './commit_reader'

module PairingMatrix
  class LocalCommitReader < CommitReader
    def initialize(config)
      super(config)
    end

    protected
    def read(since)
      commits = []
      @config.local_repositories.repositories.each do |repo|
        Dir.chdir repo do
          commits << read_commits(since)
        end
      end
      commits.flatten
    end

    private
    def read_commits(since)
      `git log --oneline --after=\"#{since}\"`.split("\n")
    end
  end
end