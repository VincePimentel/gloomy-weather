class CreatePresets < ActiveRecord::Migration[5.2]
  def change
    create_table :presets do |t|
      t.integer :user_id
      t.integer :level_id
      t.string :title, default: ""
      t.string :description, default: ""
    end
  end
end
