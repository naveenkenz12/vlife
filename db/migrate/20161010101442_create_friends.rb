class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
	    t.string :user_id, null: false
	    t.string :friend_id, null: false   
      t.string :status, null: false, default: "waiting"
      t.check "status IN ('waiting', 'following', 'accepted')", name: 'status_check'
      t.timestamps
    end
    add_index :friends, :user_id
    add_index :friends, :friend_id
    add_index :friends, [:user_id, :friend_id], unique: true
    execute %Q{ ALTER TABLE "friends" ADD FOREIGN KEY("user_id") REFERENCES "users"("u_id");}
    execute %Q{ ALTER TABLE "friends" ADD FOREIGN KEY("friend_id") REFERENCES "users"("u_id");}
  end
end
