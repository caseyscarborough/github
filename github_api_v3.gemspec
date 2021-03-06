# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_api_v3/version'

Gem::Specification.new do |spec|
  spec.name          = 'github_api_v3'
  spec.version       = GitHub::VERSION
  spec.authors       = ['Casey Scarborough']
  spec.email         = ['caseyscarborough@gmail.com']
  spec.description   = "A wrapper for GitHub's API v3."
  spec.summary       = "This gem is a wrapper that allows simple interaction with GitHub's API v3."
  spec.homepage      = 'https://github.com/caseyscarborough/github'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock', '1.11.0'
  spec.add_development_dependency 'vcr'
  spec.add_dependency 'httparty', '0.11.0'
  spec.add_dependency 'json' if RUBY_VERSION < '1.9.2'
end
