class PresetsController < ApplicationController

  get "/presets" do
    if logged_in?
      @presets = Preset.all

      erb :"/presets/index"
    else
      session[:referrer] = "/presets"

      redirect "/login"
    end
  end

  get "/presets/:slug" do
    @preset = Preset.find_by_slug(params[:slug])

    if @preset
      if logged_in?
        erb :"/presets/board"
      else
        session[:referrer] = "/presets/#{params[:slug]}"

        redirect "/login"
      end
    else
      #SHOW ERROR THAT IT DOESNT EXIST

      redirect "/"
    end
  end

  post "/presets" do

    binding.pry

    params[:title] = generate_title(params) if params[:title].strip.empty?

    #ADD DUPLICATE FIX LATER

    preset = Preset.create(title: params[:title], description: params[:description])

    preset.level = Level.create(params.except(:title, :description))

    current_user.presets << preset

    redirect "/presets/#{preset.slug}"
  end

  patch "/presets" do
    params[:title] = generate_title(params) if params[:title].strip.empty?

    #ADD DUPLICATE FIX LATER

    preset = Preset.find(params[:id])

    if preset.user_id == session[:user_id]
      preset.update(title: params[:title], description: params[:description])

      preset.level.update(params.except(:_method, :title, :description, :slug))

      redirect "/presets/#{preset.slug}"
    else
      redirect "/login"
    end
  end

  delete "/presets/:id" do
    preset = Preset.find(params[:id])

    if preset.user_id == session[:user_id]
      Preset.delete(preset.id)

      redirect "/users/#{current_user.slug}"
    else
      redirect "/login"
    end
    #ADD CONFIRM BUTTON
  end

  helpers do
    def generate_title(params)
      params.each do |key, value|
        next if key == "title" || key == "description"

        if value.to_i > 0
          params[:title] << "#{key.capitalize}-#{value}, "
        end
      end

      params[:title].gsub!(/, \z/, "")
    end
  end
end
