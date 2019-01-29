require "securerandom"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") {
      `bundle config session_secret`[142..-1]
    }
  end

  get "/" do
    erb :index
  end

  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def log_in_if_logged_out(referrer = nil)
      if !logged_in?
        session[:referrer] = referrer

        redirect "/login"
      end
    end
  end
end
