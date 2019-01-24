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

  def generate_errors(length)
    errors.add(:password, "is incorrect")
    errors.add(:password_del, "is incorrect")

    if length > 0 && length < 6
      errors.add(:password, "is too short (minimum is 6 characters)")
      errors.add(:password_del, "is too short (minimum is 6 characters)")
    elsif length == 0
      errors.add(:password, "can't be blank")
      errors.add(:password_del, "can't be blank")
    end
  end
end
