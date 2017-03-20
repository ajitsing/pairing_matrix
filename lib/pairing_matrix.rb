project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/pairing_matrix/**/*.rb', &method(:require))