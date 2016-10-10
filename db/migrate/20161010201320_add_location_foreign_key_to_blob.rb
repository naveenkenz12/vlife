class AddLocationForeignKeyToBlob < ActiveRecord::Migration[5.0]
  def change
  end
  execute %Q{ ALTER TABLE "blobs" ADD FOREIGN KEY("country", "city") REFERENCES "locations"("country", "city"); }
end
