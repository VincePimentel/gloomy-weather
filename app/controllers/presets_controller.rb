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
    title = ""

    if params[:title].nil?
      params.compact.each do |key, value|
        if key != "description"
          title << "#{key.to_s.capitalize}(#{value}) | "
        end
      end

      params[:title] = title[0...-2]
    end

    params.each do |key, value|
      if key != "description"
        params[key] = value.to_i
      end
    end

    binding.pry

    preset = Preset.create(params)
  end

  patch "/presets" do

  end

  delete "/presets/:id_or_title/delete" do

  end

  helpers do

  end
end
