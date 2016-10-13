class AddColumnAccountStatus < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :status, :boolean, default: true
  	# true = activated
  	# false = deactivated
  end
end
