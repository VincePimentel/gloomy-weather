class Preset < ActiveRecord::Base
  serialize :volume, Hash
  validates_presence_of :title
  belongs_to :user

  def slug
    self.title.gsub(/\W+/, "-").gsub(/\W+\z/,"").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |preset|
      preset.slug == slug
    end
  end

  def self.sources
    {
      rain: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/985ead5c98d",
        icon: "fas fa-cloud-rain"
      },
      thunder: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/00b6fa1a994",
        icon: "fas fa-bolt"
      },
      wave: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/7429f4ac15e",
        icon: "fas fa-umbrella-beach"
      },
      river: {
        url: "",
        icon: "fas fa-water"
      },
      wind: {
        url: "",
        icon: "fas fa-wind"
      },
      leaf: {
        url: "",
        icon: "fas fa-leaf"
      },
      fire: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/0d06fccbb48",
        icon: "fas fa-fire"
      },
      bird: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/524a66f1a53",
        icon: "fas fa-dove"
      },
      cricket: {
        url: "",
        icon: "fas fa-poop"
      },
      train: {
        url: "",
        icon: "fas fa-subway"
      },
      crowd: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/0b3022e697f",
        icon: "fas fa-coffee"
      },
      white: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/07679a81f3f",
        icon: "material-icons"
      },
      pink: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/c3f8e1315b9",
        icon: "material-icons"
      },
      brown: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/32d1e9e159e",
        icon: "material-icons"
      }
    }
  end
end
