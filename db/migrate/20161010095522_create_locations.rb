class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations, id: false do |t|
      t.string :country, null: false
      t.string :state
      t.string :city, null: false
      t.timestamps
    end
    execute %Q{ ALTER TABLE "locations" ADD PRIMARY KEY("country", "city");}
  end
end
