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
        erb :"/presets/display"
      else
        session[:referrer] = "/presets/#{params[:slug]}"

        redirect "/login"
      end
    else
      #SHOW ERROR

      redirect "/"
    end
  end

  post "/presets" do
    if params[:title].strip.empty?
      title = ""

      params[:volume].each do |key, value|
        if value.to_i > 0
          title << "#{key.capitalize}-#{value}, "
        end
      end

      params[:title] = title[0...-2]
    end

    #CHECK FOR DUPLICATES
    size = Preset.where(title: params[:title]).size

    if size > 0
      params[:title] << " #{size + 1}"
    end

    params[:volume].each do |key, value|
      params[:volume][key.to_sym] = value.to_i
    end

    preset = Preset.create(params)

    current_user.presets << preset

    redirect "/presets/#{preset.slug}"
    #ASK USER TO LOG IN FIRST BEFORE SAVING
  end

  patch "/presets" do
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

    preset = Preset.find_by(params[:title])

    if preset.user_id == session[:user_id]
      params.delete(:_method)

      preset.update(params)

      redirect "/presets/#{preset.slug}"
    else
      redirect "/login"
    end
  end

  delete "/presets/:id" do
    preset = Preset.find(params[:id])

    if preset.user_id == session[:user_id]
      Preset.delete(params[:id])

      redirect "/users/#{current_user.slug}"
    else
      redirect "/login"
    end
    #ADD CONFIRM BUTTON
  end
end
