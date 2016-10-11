class UserProfile < ApplicationRecord
	belongs_to :user , :class_name => 'User', :foreign_key => 'u_id'

end
