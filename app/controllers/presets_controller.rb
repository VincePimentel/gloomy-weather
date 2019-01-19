class PresetsController < ApplicationController
  get "/presets" do
    @presets = Preset.all

    erb :"/presets/index"
    #display all presets by other users
  end

  get "/presets/:id_or_title" do
    #display all presets by slug
  end

  post "/presets" do
    if params[:title].strip.empty?
      title = ""

      params.each do |key, value|
        if !["title"].include?(key) && !value.empty?
          title << "#{key.to_s.gsub("_volume", "").capitalize}(#{value}) | "
        end
      end

      params[:title] = title[0...-3]
    end

    params.each do |key, value|
      if !["title", "description"].include?(key)
        params[key.to_sym] = value.to_i
      end
    end

    session[:preset] = Preset.create(params)

    current_user.presets << session[:preset]

    #ASK USER TO LOG IN FIRST BEFORE SAVING
  end

  patch "/presets" do

  end

  delete "/presets/:id_or_title/delete" do

  end

  helpers do

  end
end
