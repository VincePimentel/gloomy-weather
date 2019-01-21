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

    if @preset
      if logged_in?
        session[:preset] = @preset

        erb :"/presets/display"
      else
        session[:previous] = "/presets/#{params[:slug]}"

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

    params[:volume].each do |key, value|
      params[:volume][key.to_sym] = value.to_i
    end

    binding.pry

    preset = Preset.create(params)

    current_user.presets << preset

    session[:preset] = preset

    redirect "/presets/#{preset.slug}"
    # if logged_in?
    #
    # else
    #   redirect "/login"
    # end
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

    preset = Preset.find(session[:preset].id)

    params.delete(:_method)

    preset.update(params)

    session[:preset] = preset

    redirect "/presets/#{preset.slug}"
    # if logged_in?
    #
    # else
    #   redirect "/login"
    # end
  end

  delete "/presets/:id" do
    preset = Preset.find(params[:id])

    if preset.user_id == session[:user_id]
      Preset.delete(params[:id])

      redirect "/users/#{current_user.slug}"
    else
      redirect "/login"
    end
    # if logged_in?
    #
    # else
    #   redirect "/login"
    # end
    #ADD CONFIRM BUTTON
  end
end
