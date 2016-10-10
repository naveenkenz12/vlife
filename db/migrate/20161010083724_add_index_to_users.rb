class AddIndexToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_index :users, :email, unique: true
  	add_index :users, :phone_no, unique: true
  end
end
