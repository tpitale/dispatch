source "http://rubygems.org"

gem 'rake', '0.8.7'
gem 'thin'
gem 'capistrano'
gem 'capistrano-ext'
gem 'railsless-deploy', :require => false

group :application do
  gem 'sinatra'
end

group :daemon do
  gem 'yajl-ruby'
  gem 'eventmachine'
  gem 'em-websocket'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'spork', '~> 0.9.0.rc9'
  gem 'mocha'
  gem 'bourne'
end
