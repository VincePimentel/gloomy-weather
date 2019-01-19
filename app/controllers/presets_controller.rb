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
    binding.pry
  end

  patch "/presets" do

  end

  delete "/presets/:id_or_title/delete" do

  end

  helpers do

  end
end
