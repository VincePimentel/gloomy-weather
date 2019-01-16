class CreatePresets < ActiveRecord::Migration[5.2]
  def change
    create_table :presets do |t|
      t.integer :user_id
      t.integer :rain_volume
      t.integer :river_volume
      t.integer :wave_volume
      t.integer :wind_volume
      t.integer :leaf_volume
      t.integer :thunder_volume
      t.integer :fire_volume
      t.integer :bird_volume
      t.integer :cricket_volume
      t.integer :crowd_volume
      t.integer :train_volume
      t.integer :white_volume
      t.integer :pink_volume
      t.integer :brown_volume
    end
  end
end
