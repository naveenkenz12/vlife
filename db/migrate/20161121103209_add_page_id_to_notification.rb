class AddPageIdToNotification < ActiveRecord::Migration[5.0]
  def change
  end
  add_column :notifications, :page_id, :string
  execute %Q{ ALTER TABLE "notifications" ADD FOREIGN KEY("page_id") REFERENCES "group_pages"("page_id"); }
end
