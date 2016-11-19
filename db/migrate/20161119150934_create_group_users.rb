class CreateGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_users do |t|
      t.string :page_id, null: false
      t.string :u_id, null: false
      t.string :status, null: false, default: "P"
      t.check "status IN ('P', 'J', 'A', 'I')", name: 'status_check'
      t.timestamps
    end
    execute %Q{ ALTER TABLE "group_users" ADD FOREIGN KEY("page_id") REFERENCES "group_pages"("page_id"); }
    execute %Q{ ALTER TABLE "group_users" ADD FOREIGN KEY("u_id") REFERENCES "users"("u_id"); }
  end
end

#P=Pending
#J=Joined
#A=Admin
#I=Invited