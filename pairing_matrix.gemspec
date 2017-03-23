# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pairing_matrix/version'

Gem::Specification.new do |spec|
  spec.name          = 'pairing_matrix'
  spec.version       = PairingMatrix::VERSION
  spec.authors       = ['Ajit Singh']
  spec.email         = ['jeetsingh.ajit@gmail.com']
  spec.summary       = 'Draw pairing matrix from given repos and configurations'
  spec.description   = 'Draw pairing matrix from given repos and configurations'
  spec.homepage      = 'https://github.com/ajitsing/pairing_matrix'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency   'bundler', '~> 1.6'
  spec.add_dependency               'sinatra', '~> 1.4.8'
end
