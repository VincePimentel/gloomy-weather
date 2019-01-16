class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET")
  end

  get "/" do
    "Hello World!"
  end

  helpers do

  end
end
