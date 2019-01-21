class Preset < ActiveRecord::Base
  belongs_to :user
  belongs_to :volume

  def slug
    self.title.gsub(/\W+/, "-").gsub(/\W+\z/,"").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |preset|
      preset.slug == slug
    end
  end
end
