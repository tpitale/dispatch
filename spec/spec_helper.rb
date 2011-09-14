ENV['RACK_ENV'] = 'test'
require File.dirname(__FILE__) + '/../dispatch'
require 'rack/test'

RSpec.configure do |config|
  config.mock_with :mocha
  config.include Rack::Test::Methods
end

def app
  Sinatra::Application
end

# require 'spork'
# 
# Spork.prefork do
# end
# 
# Spork.each_run do
#   require File.dirname(__FILE__) + '/../dispatch'
# end
