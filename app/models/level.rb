class Level < ActiveRecord::Base
  has_many :presets
  has_many :users, through: :presets
end
