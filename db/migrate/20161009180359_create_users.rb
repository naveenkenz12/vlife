class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :u_id
      t.string :password	#stored as encrypted
      t.string :email
      t.string :phone_no
      t.string :salt		#for paassword
      t.timestamps
    end
  end
end
