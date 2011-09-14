$: << '.'

require 'boot'

get '/' do
  @projects = Project.all
  erb :index
end
