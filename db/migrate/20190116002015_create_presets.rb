class CreatePresets < ActiveRecord::Migration[5.2]
  def change
    create_table :presets do |t|
      t.integer :user_id
      t.integer :volume_id
      t.string :title
      t.string :description
    end
  end
end
