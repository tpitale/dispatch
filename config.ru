$: << '.' unless $:.include?('.')
require 'dispatch'

run Sinatra::Application