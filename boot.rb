require 'rubygems'
require 'config'

require 'bundler'
Bundler.setup(:default, Config.environment)
Bundler.require(:default, Config.environment)

set :environment, Config.environment.to_sym

env_file_path = "config/#{Config.environment}"
require env_file_path if File.exists?(env_file_path)

# Models
autoload :Project, 'models/project'
