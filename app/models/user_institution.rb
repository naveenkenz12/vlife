class UserInstitution < ApplicationRecord
	belongs_to :institute_of, :class_name => "User", :inverse_of => "institute"
	belongs_to :institute_for, :class_name => "Institution", :inverse_of => "institute_user"

	validates :u_id, :presence => true
	validates :ins_id, :presence => true

	default_scope -> { order(start: :desc)}
end
