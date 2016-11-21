class CreateNotifyTos < ActiveRecord::Migration[5.0]
  def change
    create_table :notify_tos do |t|
      t.string :not_id, null: false
      t.string :from_id, null: false
      t.string :to_id, null: false
      t.timestamps
    end
    add_index :notify_tos, [:not_id, :from_id, :to_id]
    add_index :notify_tos, [:to_id]
    execute %Q{ ALTER TABLE "notify_tos" ADD FOREIGN KEY("not_id") REFERENCES "notifications"("not_id"); }
    execute %Q{ ALTER TABLE "notify_tos" ADD FOREIGN KEY("from_id") REFERENCES "users"("u_id"); }
    execute %Q{ ALTER TABLE "notify_tos" ADD FOREIGN KEY("to_id") REFERENCES "users"("u_id"); }
  end
end


#notification from
#post, comment, like, post in group
#friend request sent, accepted, remove
#join, invite to group, request to group