project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pairing_matrix/**/*.rb', &method(:require))

commit_reader = PairingMatrix::CommitReader.new([])
p commit_reader.read('2017-02-26')
