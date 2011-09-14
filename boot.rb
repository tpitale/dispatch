require 'rubygems'
require 'config'

require 'bundler'
Bundler.setup(:default, :application, Configuration.environment)
Bundler.require(:default, :application, Configuration.environment)

set :environment, Configuration.environment.to_sym

env_file_path = "config/#{Configuration.environment}"
require env_file_path if File.exists?(env_file_path)

# Models
autoload :Project, 'models/project'
