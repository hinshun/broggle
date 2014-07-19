ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../dummy-app/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'


Dir[Broggle::Engine.root.join("spec/support/**/*.rb")].each { |f| require f }

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
end
