#!/usr/bin/env rake

require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "broggle"
  gem.homepage = "http://github.com/hinshun/broggle"
  gem.license = "MIT"
  gem.summary = %Q{Branch Toggling Environment}
  gem.description = %Q{Provides a web interface to remotely merging and unmerging branches into the local base branch}
  gem.email = "edgarhinshunlee@gmail.com"
  gem.authors = ["Edgar Lee"]

  gem.test_files = Dir["spec/**/*"]

  gem.add_dependency "rails", "~> 3.2.17"

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "capybara"
  gem.add_development_dependency "factory_girl_rails"
  gem.add_development_dependency "bundler", "~> 1.0"
  gem.add_development_dependency "jeweler", "~> 2.0.1"
  gem.add_development_dependency "coveralls"
end
Jeweler::RubygemsDotOrgTasks.new

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each {|f| load f}

require 'rspec/core'
require 'rspec/core/rake_taks'

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec => 'app:db:test:prepare')

task :default => :spec
