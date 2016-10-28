class AddStatusToMessages < ActiveRecord::Migration[5.0]
  def change
  	add_column :messages, :status, :string, null: true
  end
end
