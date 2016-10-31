class CreatePostLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :post_likes do |t|
   	  t.string :p_id, null: false
   	  t.string :u_id, null: false
      t.timestamps
    end
    execute %Q{ ALTER TABLE "post_likes" ADD FOREIGN KEY("p_id") REFERENCES "posts"("p_id"); }
    execute %Q{ ALTER TABLE "post_likes" ADD FOREIGN KEY("u_id") REFERENCES "users"("u_id"); }
    add_index :post_likes, :p_id
    add_index :post_likes, :u_id
    add_index :post_likes, [:p_id, :u_id], unique: true
  end
end
