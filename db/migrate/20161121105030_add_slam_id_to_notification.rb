class AddSlamIdToNotification < ActiveRecord::Migration[5.0]
  def change
  end
  add_column :notifications, :slam_id, :string
  execute %Q{ ALTER TABLE "notifications" ADD FOREIGN KEY("slam_id") REFERENCES "slams"("slam_id"); }
end
