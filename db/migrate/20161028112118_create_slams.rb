class CreateSlams < ActiveRecord::Migration[5.0]
  def change
    create_table :slams, id: false do |t|
      t.string :slam_id, null: false
      t.string :filled_by, null: false
      t.string :filled_for, null: false
      t.timestamps
    end
    execute %Q{ ALTER TABLE "slams" ADD PRIMARY KEY("slam_id"); }
    execute %Q{ ALTER TABLE "slams" ADD FOREIGN KEY("filled_by") REFERENCES "users"("u_id"); }
    execute %Q{ ALTER TABLE "slams" ADD FOREIGN KEY("filled_for") REFERENCES "users"("u_id"); }
  end
end
