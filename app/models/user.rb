class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true,
                       uniqueness: true,
                       length: { minimum: 3 }
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 6 },
                       on: :create
  validates :password, confirmation: true,
                       length: { minimum: 6 },
                       allow_blank: true,
                       on: :update
  has_many :presets

  def slug
    self.username.gsub(/\W+/, "-").gsub(/\W+\z/,"").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end
end
