class PresetsController < ApplicationController
  get "/presets" do
    if logged_in?
      @presets = Preset.all

      erb :"/presets/index"
    else
      session[:previous] = "/presets"

      redirect "/login"
    end
  end

  get "/presets/:slug" do
    @preset = Preset.find_by_slug(params[:slug])

    #CHECK IF IT'S MY SLUG

    if @preset
      if logged_in?
        erb :"/presets/show"
      else
        session[:previous] = "/presets/#{params[:slug]}"

        redirect "/login"
      end
    else
      #OR SHOW 404

      redirect "/"
    end
  end

  post "/presets" do
    if logged_in?
      if params[:title].strip.empty?
        title = ""

        params[:volume].each do |key, value|
          if value.to_i > 0
            title << "#{key.capitalize}-#{value}, "
          end
        end

        params[:title] = title[0...-2]
      end

      params[:volume].each do |key, value|
        params[:volume][key.to_sym] = value.to_i
      end

      preset = Preset.create(params)

      current_user.presets << preset

      session[:preset] = params[:volume]

      redirect "/presets/#{preset.slug}"
    else

      binding.pry
    end


    #ASK USER TO LOG IN FIRST BEFORE SAVING
  end

  patch "/presets" do

  end

  delete "/presets/:slug/delete" do

  end

  helpers do

  end
end
