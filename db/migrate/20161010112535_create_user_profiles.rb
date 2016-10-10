class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles, id: false do |t|
      t.string :u_id, null: false
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name
      t.string :gender, null: false
      t.string :language
      t.date :birthday, null: false
      t.string :rel_status
      t.string :privacy, null: false, default: "O"	# O=open
      t.string :country
      t.string :state
      t.string :city
      t.check "gender IN ('M', 'F', 'O')", name: 'gender_check'		#male, female, others
      t.check "privacy IN ('O','F', 'C')", name: 'privacy_check'	#open, friends, closed
      t.check "birthday < now()", name: 'birthday_check'
      t.timestamps
    end
    execute %Q{ ALTER TABLE "user_profiles" ADD PRIMARY KEY("u_id");}
    execute %Q{ ALTER TABLE "user_profiles" ADD FOREIGN KEY("country", "city") REFERENCES "locations"("country","city");}
    execute %Q{ ALTER TABLE "user_profiles" ADD FOREIGN KEY("u_id") REFERENCES "users"("u_id");}
  end
end
