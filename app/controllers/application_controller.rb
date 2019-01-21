require "securerandom"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(20) }
  end

  get "/" do
    @preset = new_preset
    @validation = validation_form

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

    def new_preset
      Preset.create({
        title: "",
        description: "",
        volume: {
          rain: 0,
          thunder: 0,
          wave: 0,
          river: 0,
          wind: 0,
          leaf: 0,
          fire: 0,
          bird: 0,
          cricket: 0,
          train: 0,
          crowd: 0,
          white: 0,
          pink: 0,
          brown: 0
        }
        })
    end
  end
end
