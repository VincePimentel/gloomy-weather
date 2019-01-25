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

  def self.icon(element)
    case element
    when "fire"
      "whatshot"
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

  def self.source(element)
    case element
    when "rain"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/682b42b13c5",
        icon: "fas fa-cloud-rain"
      }
    when "thunder"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/9f359d57783",
        icon: "fas fa-bolt"
      }
    when "beach"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/7977520f309",
        icon: "fas fa-umbrella-beach"
      }
    when "river"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/97a49e57fc8",
        icon: "fas fa-water"
      }
    when "garden"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/2a75c949fde",
        icon: "fas fa-spa"
      }
    when "fire"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/73d0d2aef52",
        icon: "material-icons"
        #icon: "fas fa-fire"
      }
    when "bird"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/0267c016d36",
        icon: "fas fa-dove"
      }
    when "night"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/a22ab336baa",
        icon: "fas fa-moon"
      }
    when "train"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/40bba114fd5",
        icon: "fas fa-subway"
      }
    when "cafe"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/419032046fc",
        icon: "fas fa-coffee"
      }
    when "womb"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/ea6ff8c7422",
        icon: "fas fa-baby"
      }
    when "brown"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/32d1e9e159e",
        icon: "fas fa-tv"
      }
    end
  end
end
