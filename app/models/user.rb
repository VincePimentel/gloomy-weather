class User < ActiveRecord::Base
  has_secure_password
  #validates_presence_of :username, :email, :password
  has_many :presets

  def slug
    self.username.gsub(/\W/, "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end
end
