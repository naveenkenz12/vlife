class AddProfilePicToUserProfiles < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_profiles, :profile_pic, :string, null: true
  end
end
