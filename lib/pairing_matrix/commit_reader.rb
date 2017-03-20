module PairingMatrix
  class CommitReader
    def initialize(config)
      @config = config
    end

    def read(since)
      commits = []
      @config.repos.each do |repo|
        Dir.chdir repo do
          commits << read_commits(since)
        end
      end
      commits.flatten
    end

    def authors(since)
      commits = read(since)
      commits.map do |commit|
        commit.scan(/#{@config.authors_regex}/).flatten.compact.reject(&:empty?).join(',')
      end.compact.reject(&:empty?)
    end

    private
    def read_commits(since)
      `git log --oneline --after=\"#{since}\"`.split("\n")
    end
  end
end