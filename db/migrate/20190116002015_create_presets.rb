class CreatePresets < ActiveRecord::Migration[5.2]
  def change
    create_table :presets do |t|
      t.integer :user_id
      t.integer :rain_volume, default: 0
      t.integer :river_volume, default: 0
      t.integer :wave_volume, default: 0
      t.integer :wind_volume, default: 0
      t.integer :leaf_volume, default: 0
      t.integer :thunder_volume, default: 0
      t.integer :fire_volume, default: 0
      t.integer :bird_volume, default: 0
      t.integer :cricket_volume, default: 0
      t.integer :crowd_volume, default: 0
      t.integer :train_volume, default: 0
      t.integer :white_volume, default: 0
      t.integer :pink_volume, default: 0
      t.integer :brown_volume, default: 0
    end
  end
end
