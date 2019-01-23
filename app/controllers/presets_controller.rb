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

  post "/presets" do
    params[:title] = generate_title(params) if params[:title].strip.empty?

    preset = Preset.create(params)

    current_user.presets << preset

    redirect "/presets/#{preset.id}/#{preset.slug}"
  end

  get "/presets/:id/:slug" do
    @preset = Preset.find(params[:id])

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

  patch "/presets/:id/:slug" do
    params[:title] = generate_title(params) if params[:title].strip.empty?

    preset = Preset.find(params[:id])

    if preset.user_id == session[:user_id]
      preset.update(params.except(:_method, :id, :slug))

      redirect "/presets/#{preset.id}/#{preset.slug}"
    else
      redirect "/login"
    end
  end

  delete "/presets/:id/:slug" do
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
