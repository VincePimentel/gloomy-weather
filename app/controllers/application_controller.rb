require "securerandom"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(20) }
  end

  get "/" do
    if logged_in?
      @preset = (session[:preset] || current_user.presets.last) || Preset.all[0]
    else
      @validation = validation_form

      @preset = Preset.all[0]
    end

    erb :index
  end

  get "/test" do
    erb :test
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
