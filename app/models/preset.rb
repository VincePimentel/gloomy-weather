class Preset < ActiveRecord::Base
  belongs_to :user

  def self.sources
    %w[
      https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/aee2e72d788

      https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/795b33f56f2

      https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/06259a051ee

      https://jukehost.co.uk/api/audio/9cc957e015992dfb78334f2cb34a630953a7aaf0/f22c3aaed90
    ]
  end
end
