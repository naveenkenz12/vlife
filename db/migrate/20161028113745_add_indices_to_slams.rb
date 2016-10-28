class AddIndicesToSlams < ActiveRecord::Migration[5.0]
  def change
  end
  add_index :slams, :filled_by
  add_index :slams, :filled_for
  add_index :slams, [:filled_by, :filled_for], unique: true
end
