require 'sinatra/base'
require 'sequel'

require 'models/base'

module IdeaBox

  # Sinatra::Base - Middleware, Libraries, and Modular Apps
  #
  # Defining your app at the top-level works well for micro-apps but has
  # considerable drawbacks when building reusable components such as Rack
  # middleware, Rails metal, simple libraries with a server component, or even
  # Sinatra extensions. The top-level DSL pollutes the Object namespace and
  # assumes a micro-app style configuration (e.g., a single application file,
  # ./public and ./views directories, logging, exception detail page, etc.).
  # That's where Sinatra::Base comes into play:
  #
  class Server < Sinatra::Base
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
  end
end