class Institution < ApplicationRecord
	has_many :institute_user, :class_name => "UserInstitution", dependent: :destroy, :foreign_key => "ins_id", :inverse_of => :institute_for

	validates :ins_id, :presence => true, :uniqueness => true
	validates :name, :presence => true
	validates :country, :presence => true
	validates :city, :presence => true

	default_scope -> { order(created_at: :desc)}
end
