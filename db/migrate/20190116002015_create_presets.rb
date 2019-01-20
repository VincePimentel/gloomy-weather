class CreatePresets < ActiveRecord::Migration[5.2]
  def change
    create_table :presets do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.text :volume
    end
  end
end
