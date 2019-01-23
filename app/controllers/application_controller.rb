require "securerandom"
require "rack-flash"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(64) }

    use Rack::Flash
  end

  get "/" do
    erb :index
  end

  get "/test" do
    erb :test
  end

  post "/test" do
    flash[:message] = "test"

    redirect "/test"
  end

  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
