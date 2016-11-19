class GroupUser < ApplicationRecord
	belongs_to :group_of_user, :class_name => "User", :inverse_of => "group"
	belongs_to :member_of_group, :class_name => "GroupPage", :inverse_of => "group_member"

	validates :page_id, presence: true
	validates :u_id, presence: true
	validates :status, presence: true
end
