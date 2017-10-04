# coding: utf-8

# rubocop:disable Metrics/LineLength
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'graphql/validation/version'

Gem::Specification.new do |spec|
  spec.name          = 'graphql-validation'
  spec.version       = Graphql::Validation::VERSION
  spec.authors       = ['Ian Ker-Seymer']
  spec.email         = ['ian@tryadhawk.com']

  spec.summary       = 'Validate graphql-ruby arguments easily with dry-validation'
  spec.description   = 'Validate graphql-ruby arguments easily with dry-validation'
  spec.homepage      = 'https://github.com/adhawk/graphql-validation'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'graphql', '~> 1.7.3'
  spec.add_dependency 'dry-validation', '~> 0.11.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
# rubocop:enable Metrics/LineLength
