class PresetsController < ApplicationController
  get "/presets" do
    @presets = Preset.all

    erb :"/presets/index"
    #display all presets by other users
  end

  get "/presets/:id_or_slug" do
    if params[:slug].is_a?(Integer)
      @preset = Preset.find(params[:id])
    else
      @preset = Preset.find_by_slug(params[:slug])
    end

    erb :"/presets/show"
    #display presets by slug
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

    erb :index

    #ASK USER TO LOG IN FIRST BEFORE SAVING
  end

  patch "/presets" do

  end

  delete "/presets/:id_or_slug/delete" do

  end

  helpers do

  end
end
