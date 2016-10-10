class CreateBlobs < ActiveRecord::Migration[5.0]
  def change
    create_table :blobs, id: false do |t|
      t.string :med_id, null: false, unique: true
      t.string :description
      t.binary :content, null: false
      t.string :country
      t.string :state
      t.string :city
      t.timestamps
    end
    execute %Q{ ALTER TABLE "blobs" ADD PRIMARY KEY("med_id"); }
  end
end
