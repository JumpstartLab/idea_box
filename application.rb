current_path = File.expand_path('../',__FILE__)
$LOAD_PATH.push(current_path) unless $LOAD_PATH.include?($LOAD_PATH)

Bundler.require

require 'sinatra/sequel'
set :database, 'sqlite://db/ideabox.sqlite3'

require 'models/idea'

get '/' do
  @ideas = Idea.all
  erb :index
end

post '/create' do
  # 1. Create an idea based on the form parameters
  idea = Idea.new
  idea.title = params[:idea_name]
  idea.description = params[:idea_description]
  
  # 2. Store it
  idea.save

  # 3. Send us back to the index page to see all ideas
  redirect to('/')
end

get '/ideas/:id' do
  @idea = Idea.find(params[:id])
  erb :show
end

not_found do
  erb :error
end
