class Preset < ActiveRecord::Base
  belongs_to :user

  def slug
    self.title.gsub(/\W+/, "-").gsub(/\W+\z/,"").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |preset|
      preset.slug == slug
    end
  end

  def self.elements
    %w[
      rain
      thunder
      beach
      river
      garden
      fire
      bird
      night
      train
      cafe
      womb
      brown
    ]
  end

  private

  def self.source
    path = "/assets/audios/"
    icon = "fas fa-"

    {
      rain: {
          path: "#{path}rain.mp3",
          icon: "#{icon}cloud-rain"
      },
      thunder: {
          path: "#{path}thunder.mp3",
          icon: "#{icon}bolt"
      },
      beach: {
          path: "#{path}beach.mp3",
          icon: "#{icon}umbrella-beach"
      },
      river: {
          path: "#{path}river.mp3",
          icon: "#{icon}water"
      },
      garden: {
          path: "#{path}garden.mp3",
          icon: "#{icon}spa"
      },
      fire: {
          path: "#{path}fire.mp3",
          icon: "#{icon}fire-alt"
      },
      bird: {
          path: "#{path}bird.mp3",
          icon: "#{icon}dove"
      },
      night: {
          path: "#{path}night.mp3",
          icon: "#{icon}moon"
      },
      train: {
          path: "#{path}train.mp3",
          icon: "#{icon}subway"
      },
      cafe: {
          path: "#{path}cafe.mp3",
          icon: "#{icon}coffee"
      },
      womb: {
          path: "#{path}womb.mp3",
          icon: "#{icon}baby"
      },
      brown: {
          path: "#{path}brown.mp3",
          icon: "#{icon}tv"
      }
    }
  end
end
