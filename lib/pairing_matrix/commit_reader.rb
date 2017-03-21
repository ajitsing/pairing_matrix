require 'date'

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
        commit.scan(/#{@config.authors_regex}/).flatten.compact.reject(&:empty?).sort.join(',')
      end.compact.reject(&:empty?)
    end

    def authors_with_commits(days)
      date = (Date.today - days).to_s
      authors = authors(date)
      author_groups = authors.group_by { |n| n }
      author_groups.map do |k, v|
        pair = k.split(',')
        pair.unshift('') if pair.size == 1
        [pair, v.size].flatten
      end
    end

    private
    def read_commits(since)
      `git log --oneline --after=\"#{since}\"`.split("\n")
    end
  end
end