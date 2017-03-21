require_relative '../lib/pairing_matrix'

config_reader = PairingMatrix::ConfigReader.new('pairing_matrix.yml')
config = config_reader.config
commit_reader = PairingMatrix::CommitReader.new(config)
authors = commit_reader.authors('2017-02-26')
author_groups = authors.group_by {|n| n}
author_groups.map {|k,v| [k.split(','), v.size].flatten }

# File.open('commits.txt', 'w') do |file|
#   commits.each { |commit| file.write commit + "\n" }
# end