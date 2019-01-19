class PresetsController < ApplicationController
  get "/presets" do
    @presets = Preset.all

    erb :"/presets/index"
    #display all presets by other users
  end

  get "/presets/:slug" do
    @preset = Preset.find_by_slug(params[:slug])

    erb :"/presets/show"
    #display presets by slug
  end

  post "/presets" do
    if params[:title].strip.empty?
      title = ""

      params[:volume].each do |key, value|
        if value.to_i > 0
          title << "#{key.capitalize}(#{value}) | "
        end
      end

      params[:title] = title[0...-3]
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

  end

  delete "/presets/:slug/delete" do

  end

  helpers do

  end
end
