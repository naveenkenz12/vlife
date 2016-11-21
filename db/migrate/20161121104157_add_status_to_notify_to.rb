class AddStatusToNotifyTo < ActiveRecord::Migration[5.0]
  def change
  end
  add_column :notify_tos, :status, :string, null: false
end


#status = N(not sent), S(sent), R(complete)