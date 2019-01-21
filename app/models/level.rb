class Level < ActiveRecord::Base
  has_many :presets
  has_many :users, through: :presets

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
      beach: {
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
