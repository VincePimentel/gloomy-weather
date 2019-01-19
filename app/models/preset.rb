class Preset < ActiveRecord::Base
  belongs_to :user

  def slug
    self.title.gsub(/\W+/, "-").chop.downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |preset|
      preset.slug == slug
    end
  end

  def self.sources
    {
      rain: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/aee2e72d788",
        icon: "fas fa-cloud-rain"
      },
      thunder: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/795b33f56f2",
        icon: "fas fa-bolt"
      },
      wave: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/06259a051ee",
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
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/f22c3aaed90",
        icon: "fas fa-fire"
      },
      bird: {
        url: "",
        icon: "fas fa-dove"
      },
      cricket: {
        url: "",
        icon: ""
      },
      train: {
        url: "",
        icon: "fas fa-subway"
      },
      crowd: {
        url: "",
        icon: "fas fa-coffee"
      },
      white: {
        url: "",
        icon: ""
      },
      pink: {
        url: "",
        icon: ""
      },
      brown: {
        url: "",
        icon: ""
      }
    }
  end
end
