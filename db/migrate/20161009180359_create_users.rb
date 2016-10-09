class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: false do |t|
      #t.primary_key :u_id
      t.string :u_id, null: false, unique: true
      t.string :password, null: false
      t.string :email, null: false, unique: true
      t.string :phone_no, null: false, unique: true
      t.string :salt
      t.timestamps
    end
    execute %Q{ ALTER TABLE "users" ADD PRIMARY KEY("u_id");}
  end
end
