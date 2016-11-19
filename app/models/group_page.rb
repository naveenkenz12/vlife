class GroupPage < ApplicationRecord
	has_many :group_member, :class_name => "GroupUser", dependent: :destroy, :foreign_key => "page_id", :inverse_of => :member_of_group
	validates :page_id, presence: true, uniqueness: true

end
