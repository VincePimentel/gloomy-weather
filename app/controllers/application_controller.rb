require "securerandom"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(20) }
  end

  get "/" do
    @logged_in = logged_in? ? true : false

    erb :index
  end

  helpers do
    def current_user
      User.find_by_id(session[:id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
