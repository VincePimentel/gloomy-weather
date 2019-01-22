class CreateLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :levels do |t|
      t.integer :rain, default: 0
      t.integer :thunder, default: 0
      t.integer :beach, default: 0
      t.integer :river, default: 0
      t.integer :wind, default: 0
      t.integer :fire, default: 0
      t.integer :bird, default: 0
      t.integer :cricket, default: 0
      t.integer :train, default: 0
      t.integer :crowd, default: 0
      t.integer :pink, default: 0
      t.integer :brown, default: 0
    end
  end
end