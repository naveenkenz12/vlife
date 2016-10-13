class AddParentToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :parent_id, :string, null: true
  end
end
