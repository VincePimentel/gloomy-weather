class Preset < ActiveRecord::Base
  belongs_to :user

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
      fire: {
        url: "https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/f22c3aaed90",
        icon: "fas fa-fire"
      }
    }
  end
end
