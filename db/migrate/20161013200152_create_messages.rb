class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: false do |t|
      t.string :msg_id, null: false, unique: true
      t.string :content
      t.string :sender, null: false
      t.string :receiver, null: false
      t.string :med_id
      t.timestamps
    end
    execute %Q{ ALTER TABLE "messages" ADD PRIMARY KEY("msg_id"); }
    execute %Q{ ALTER TABLE "messages" ADD FOREIGN KEY("sender") REFERENCES "users"("u_id"); }
    execute %Q{ ALTER TABLE "messages" ADD FOREIGN KEY("receiver") REFERENCES "users"("u_id"); }
    execute %Q{ ALTER TABLE "messages" ADD FOREIGN KEY("med_id") REFERENCES "blobs"("med_id"); }
  end
end
