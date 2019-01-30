class PresetsController < ApplicationController

  get "/presets" do
    log_in_if_logged_out(request.path)

    @presets = Preset.all

    erb :"/presets/index"
  end

  post "/presets" do
    params[:title] = generate_title(params) if params[:title].strip.empty?

    preset = Preset.create(params)

    current_user.presets << preset

    redirect "/presets/#{preset.id}/#{preset.slug}"
  end

  get "/presets/:id/:slug" do
    log_in_if_logged_out(request.path)

    @preset = Preset.find(params[:id])

    if @preset
      erb :"/presets/show"
    else
      redirect "/"
    end
  end

  patch "/presets/:id/:slug" do
    preset = Preset.find(params[:id])

    binding.pry

    if preset.user == current_user
      params[:title] = generate_title(params) if params[:title].strip.empty?

      preset.update(params.except(:_method, :id, :slug))

      redirect "/presets/#{preset.id}/#{preset.slug}"
    else
      redirect "/login"
    end
  end

  delete "/presets/:id/:slug" do
    preset = Preset.find(params[:id])

    if preset.user == current_user
      Preset.delete(preset.id)

      redirect "/users/#{current_user.slug}"
    else
      redirect "/login"
    end
  end

  helpers do

    def generate_title(params)
      extras = %w[
        _method
        id
        slug
        title
        description
      ]

      params.each do |key, value|
        next if extras.include?(key)

        if value.to_i > 0
          params[:title] << "#{key.capitalize}-#{value}, "
        end
      end

      params[:title].gsub!(/, \z/, "")
    end
  end

end
