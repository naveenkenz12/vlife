class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts, id: false do |t|
      t.string :p_id, null: false, unique: true
      t.string :content
      t.string :country
      t.string :state
      t.string :city
      t.string :posted_by_id
      t.string :media_id
      t.string :posted_to_id
      t.string :page_id
      t.check "posted_to_id is not null or posted_by_id is not null", name: 'post_to_psge_or_user_check'
      t.check "content is not null or media_id is not null", name: 'content_or_media_check'
      t.timestamps
    end
    execute %Q{ ALTER TABLE "posts" ADD PRIMARY KEY("p_id"); }
    execute %Q{ ALTER TABLE "posts" ADD FOREIGN KEY("country", "city") REFERENCES "locations"("country", "city"); }
    execute %Q{ ALTER TABLE "posts" ADD FOREIGN KEY("posted_by_id") REFERENCES "users"("u_id"); }
    execute %Q{ ALTER TABLE "posts" ADD FOREIGN KEY("posted_to_id") REFERENCES "users"("u_id"); }
    execute %Q{ ALTER TABLE "posts" ADD FOREIGN KEY("media_id") REFERENCES "blobs"("med_id"); }
  end
end
