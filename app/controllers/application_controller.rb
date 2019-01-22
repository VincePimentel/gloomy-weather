require "securerandom"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(64) }
  end

  get "/" do
    level = Level.new

    @preset = Preset.new
    @preset.level = level

    session[:preset] = @preset

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

    def icon(element)
      case element
      when "fire"
        "whatshot"
      when "pink", "brown"
        "waves"
      end
    end

    def source(element)
      case element
      when "rain"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/985ead5c98d",
          icon: "fas fa-cloud-rain"
        }
      when "thunder"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/00b6fa1a994",
          icon: "fas fa-bolt"
        }
      when "beach"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/7429f4ac15e",
          icon: "fas fa-umbrella-beach"
        }
      when "river"
        {
          url: "",
          icon: "fas fa-water"
        }
      when "wind"
        {
          url: "",
          icon: "fas fa-wind"
        }
      when "fire"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/0d06fccbb48",
          icon: "material-icons"
          #icon: "fas fa-fire"
        }
      when "bird"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/524a66f1a53",
          icon: "fas fa-dove"
        }
      when "cricket"
        {
          url: "",
          icon: "fas fa-poop"
        }
      when "train"
        {
          url: "",
          icon: "fas fa-subway"
        }
      when "crowd"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/0b3022e697f",
          icon: "fas fa-coffee"
        }
      when "pink"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/c3f8e1315b9",
          icon: "material-icons"
        }
      when "brown"
        {
          url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/32d1e9e159e",
          icon: "material-icons"
        }
      end
    end
  end
end
