class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends, id: false do |t|
	    t.string :user, null: false
	    t.string :friend, null: false   
      t.string :status, null: false, default: "waiting"
      t.check "status IN ('waiting', 'following', 'accepted')", name: 'status_check'
      t.timestamps
    end
    add_index :friends, :user
    add_index :friends, :friend
    add_index :friends, [:user, :friend], unique: true
    execute %Q{ ALTER TABLE "friends" ADD PRIMARY KEY("user", "friend");}
    execute %Q{ ALTER TABLE "friends" ADD FOREIGN KEY("user") REFERENCES "users"("u_id");}
    execute %Q{ ALTER TABLE "friends" ADD FOREIGN KEY("friend") REFERENCES "users"("u_id");}
  end
end
