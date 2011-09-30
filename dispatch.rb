require_relative 'boot'

get '/' do
  @projects = Project.all
  erb :index
end
