class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :country, null: false
      t.string :state
      t.string :city, null: false
      t.timestamps
    end
    add_index :locations, [:country, :city]
    add_index :locations, [:country]
    add_index :locations, [:country, :state, :city]
  end
end
