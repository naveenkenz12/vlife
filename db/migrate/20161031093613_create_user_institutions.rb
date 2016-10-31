class CreateUserInstitutions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_institutions do |t|
      t.string :u_id, null: false
      t.string :ins_id, null: false
      t.date :start
      t.date :end
      t.timestamps
    end
    execute %Q{ ALTER TABLE "user_institutions" ADD FOREIGN KEY("u_id") REFERENCES "users"("u_id"); }
    execute %Q{ ALTER TABLE "user_institutions" ADD FOREIGN KEY("ins_id") REFERENCES "institutions"("ins_id"); }
    add_index :user_institutions, :u_id
    add_index :user_institutions, :ins_id
    add_index :user_institutions, [:u_id, :ins_id], unique: true
  end
end
