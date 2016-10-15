class Friend < ApplicationRecord
	belongs_to :friend_1, :class_name => "User", :inverse_of => :frq_sent
	belongs_to :friend_2, :class_name => "User", :inverse_of => :frq_recv
	validates :user_id, presence: true
	validates :friend_id, presence: true

	default_scope -> { order(created_at: :desc)}
end
