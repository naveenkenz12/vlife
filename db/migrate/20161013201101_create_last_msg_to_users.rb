class CreateLastMsgToUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :last_msg_to_users, id: false do |t|
      t.string :u_id
      t.string :msg_id
      t.timestamps
    end
    execute %Q{ ALTER TABLE "last_msg_to_users" ADD PRIMARY KEY("u_id"); }
    execute %Q{ ALTER TABLE "last_msg_to_users" ADD FOREIGN KEY("u_id") REFERENCES "users"("u_id") ; }
    execute %Q{ ALTER TABLE "last_msg_to_users" ADD FOREIGN KEY("msg_id") REFERENCES "messages"("msg_id"); }
  end
end
