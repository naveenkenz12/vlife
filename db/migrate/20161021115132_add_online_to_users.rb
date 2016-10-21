class AddOnlineToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :last_online, :datetime
  end
end
