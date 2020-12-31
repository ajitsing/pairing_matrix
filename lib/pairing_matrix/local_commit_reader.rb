require 'date'

module PairingMatrix
  class LocalCommitReader
    def initialize(config)
      @config = config
    end

    def read(since)
      commits = []
      @config.local_repositories.repositories.each do |repo|
        Dir.chdir repo do
          commits << read_commits(since)
        end
      end
      commits.flatten
    end

    def authors(since)
      commits = read(since)
      commits.map do |commit|
        commit.scan(/#{@config.authors_regex}/).flatten.compact.reject(&:empty?).map { |name| name.gsub(' ', '') }.sort.join(',')
      end.compact.reject(&:empty?)
    end

    def titleize(name)
      name.gsub(/\w+/) do |word|
        word.capitalize
      end
    end

    def authors_with_commits(days)
      date = (Date.today - days).to_s
      authors = authors(date)
      author_groups = authors.group_by { |n| titleize(n)}
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