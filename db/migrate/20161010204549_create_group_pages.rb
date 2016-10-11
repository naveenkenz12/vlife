class CreateGroupPages < ActiveRecord::Migration[5.0]
  def change
    create_table :group_pages, id: false do |t|
      t.string :page_id, null: false, unique: true
      t.string :description
      t.string :page_pic
      t.timestamps
    end
    execute %Q{ ALTER TABLE "group_pages" ADD PRIMARY KEY("page_id"); }
    execute %Q{ ALTER TABLE "group_pages" ADD FOREIGN KEY("page_pic") REFERENCES "blobs"("med_id"); }
  end
end
