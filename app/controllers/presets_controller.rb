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

      params[:volume].each do |key, value|
        title << "#{key.capitalize}(#{value}) | "
      end

      params[:title] = title[0...-3]
    end

    params[:volume].each do |key, value|
      params[:volume][key.to_sym] = value.to_i
    end

    current_user.presets << Preset.create(params)

    session[:preset] = current_user.preset.last

    binding.pry

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
