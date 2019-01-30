class CreatePresets < ActiveRecord::Migration[5.2]
  def change
    create_table :presets do |t|
      t.integer :user_id
      t.string :title, default: ""
      t.string :description, default: ""
      t.datetime :created_at
      t.integer :rain, default: 0
      t.integer :thunder, default: 0
      t.integer :beach, default: 0
      t.integer :river, default: 0
      t.integer :garden, default: 0
      t.integer :fire, default: 0
      t.integer :bird, default: 0
      t.integer :night, default: 0
      t.integer :train, default: 0
      t.integer :cafe, default: 0
      t.integer :womb, default: 0
      t.integer :brown, default: 0
    end
  end
end
