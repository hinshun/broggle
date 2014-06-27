# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'broggle/version'

Gem::Specification.new do |spec|
  spec.name          = "broggle"
  spec.version       = Broggle::VERSION
  spec.authors       = ["Edgar Lee"]
  spec.email         = ["edgarhinshunlee@gmail.com"]
  spec.summary       = %q{Branch Toggling Environment}
  spec.description   = %q{Provides a web interface to remotely merging and unmerging branches into the local base branch}
  spec.homepage      = "http://github.com/hinshun/broggle"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 3.2.17"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "factory_girl_rails"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "sqlite3"
end