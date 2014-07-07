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

  spec.add_dependency "rails", "~> 3.2.16"
  spec.add_dependency "rugged"
  
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "coveralls", "~> 0.7"
  spec.add_development_dependency "factory_girl_rails", "~> 4.4"
  spec.add_development_dependency "guard-cucumber"
  spec.add_development_dependency "guard-rspec", "~> 4.2"
  spec.add_development_dependency "pry-nav", "~> 0.2"
  spec.add_development_dependency "pry-remote", "~> 0.1"
  spec.add_development_dependency "rspec-nc", "~> 0.1"
  spec.add_development_dependency "rspec-rails", "~> 3.0"
  spec.add_development_dependency "spring-commands-cucumber"
  spec.add_development_dependency "spring-commands-rspec"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "database_cleaner"
end
