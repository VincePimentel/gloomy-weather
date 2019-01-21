class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :password
  has_many :presets
  has_many :volumes, through: :presets

  def slug
    self.username.gsub(/\W+/, "-").gsub(/\W+\z/,"").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end
end
