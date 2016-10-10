class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: false do |t|
      #t.primary_key :u_id
      t.string :u_id, unique: true, null: false
      t.string :password, null: false
      t.string :email, unique: true, null: false
      t.string :phone_no, unique: true, null: false
      t.string :salt
      t.timestamps
    end
    execute %Q{ ALTER TABLE "users" ADD PRIMARY KEY("u_id");}
  end
end
