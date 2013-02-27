require 'sinatra'
require 'sequel'

database = 'db/ideabox.sqlite3'

if ENV["IDEA_BOX_ENV"] == "test"
  database = 'db/ideabox-test.sqlite3'
end

DB = Sequel.sqlite database

require 'models/idea'


set :views, 'lib/views'

get '/' do
  @ideas = IdeaBox::Idea.all
  erb :index
end

post '/create' do
  # 1. Create an idea based on the form parameters
  idea = IdeaBox::Idea.new
  idea.title = params[:idea_name]
  idea.description = params[:idea_description]

  # 2. Store it
  idea.save

  # 3. Send us back to the index page to see all ideas
  redirect to('/')
end

get '/ideas/:id' do
  @idea = IdeaBox::Idea.find(params[:id])
  erb :show
end

not_found do
  erb :error
end
