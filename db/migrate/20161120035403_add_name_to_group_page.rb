class AddNameToGroupPage < ActiveRecord::Migration[5.0]
  def change
  end
  add_column :group_pages, :name, :string, null: false
end
