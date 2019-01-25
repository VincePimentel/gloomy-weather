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
    url = "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/"
    icon = "fas fa-"
    
    case element
    when "rain"
      {
        url: "#{url}e0453a593bb",
        icon: "#{icon}cloud-rain"
      }
    when "thunder"
      {
        url: "#{url}9f359d57783",
        icon: "#{icon}bolt"
      }
    when "beach"
      {
        url: "#{url}7977520f309",
        icon: "#{icon}umbrella-beach"
      }
    when "river"
      {
        url: "#{url}97a49e57fc8",
        icon: "#{icon}water"
      }
    when "garden"
      {
        url: "#{url}2a75c949fde",
        icon: "#{icon}spa"
      }
    when "fire"
      {
        url: "#{url}73d0d2aef52",
        icon: "#{icon}fire-alt"
      }
    when "bird"
      {
        url: "#{url}0267c016d36",
        icon: "#{icon}dove"
      }
    when "night"
      {
        url: "#{url}a22ab336baa",
        icon: "#{icon}moon"
      }
    when "train"
      {
        url: "#{url}40bba114fd5",
        icon: "#{icon}subway"
      }
    when "cafe"
      {
        url: "#{url}419032046fc",
        icon: "#{icon}coffee"
      }
    when "womb"
      {
        url: "#{url}ea6ff8c7422",
        icon: "#{icon}baby"
      }
    when "brown"
      {
        url: "#{url}32d1e9e159e",
        icon: "#{icon}tv"
      }
    end
  end
end
