class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications, id: false do |t|
      t.string :not_id, null: false
      t.string :content, null: false
      t.string :eve_id
      t.string :p_id
      t.timestamps
    end
    execute %Q{ ALTER TABLE "notifications" ADD PRIMARY KEY("not_id"); }
    execute %Q{ ALTER TABLE "notifications" ADD FOREIGN KEY("p_id") REFERENCES "posts"("p_id"); }
  end
end
