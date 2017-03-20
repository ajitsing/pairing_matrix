module PairingMatrix
  class CommitReader
    def initialize(repos)
      @repos = repos
    end

    def read(since)
      commits = []
      @repos.each do |repo|
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