Bundler.require

require './models/idea'

get '/' do
  @ideas = Idea.all
  erb :index
end

post '/create' do
  idea = Idea.new(:title => params['idea_name'], 
                  :description => params['idea_description'])
  idea.save
  redirect to('/')
end

get '/ideas/:id' do
  @idea = Idea.find(params[:id])
  erb :show
end

not_found do
  erb :error
end
