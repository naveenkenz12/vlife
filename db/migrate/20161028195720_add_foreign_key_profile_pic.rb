class AddForeignKeyProfilePic < ActiveRecord::Migration[5.0]
  def change
  end
  execute %Q{ ALTER TABLE "user_profiles" ADD FOREIGN KEY("profile_pic") REFERENCES "blobs"("med_id"); }
end
