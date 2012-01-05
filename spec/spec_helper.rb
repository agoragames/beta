require 'rspec'
require 'beta'

ENV["RAILS_ENV"] ||= 'test'
require 'dummy/config/environment'
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
end