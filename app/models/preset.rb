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
    when "pink", "brown"
      "waves"
    end
  end

  def self.elements
    %w[
      rain
      thunder
      beach
      river
      wind
      fire
      bird
      cricket
      train
      crowd
      pink
      brown
    ]
  end

  def self.source(element)
    case element
    when "rain"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/985ead5c98d",
        icon: "fas fa-cloud-rain"
      }
    when "thunder"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/00b6fa1a994",
        icon: "fas fa-bolt"
      }
    when "beach"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/7429f4ac15e",
        icon: "fas fa-umbrella-beach"
      }
    when "river"
      {
        url: "",
        icon: "fas fa-water"
      }
    when "wind"
      {
        url: "",
        icon: "fas fa-wind"
      }
    when "fire"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/0d06fccbb48",
        icon: "material-icons"
        #icon: "fas fa-fire"
      }
    when "bird"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/524a66f1a53",
        icon: "fas fa-dove"
      }
    when "cricket"
      {
        url: "",
        icon: "fas fa-poop"
      }
    when "train"
      {
        url: "",
        icon: "fas fa-subway"
      }
    when "crowd"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/0b3022e697f",
        icon: "fas fa-coffee"
      }
    when "pink"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/c3f8e1315b9",
        icon: "material-icons"
      }
    when "brown"
      {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/32d1e9e159e",
        icon: "material-icons"
      }
    end
  end
end
