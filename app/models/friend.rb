class Friend < ApplicationRecord
	belongs_to :friend_1, :class_name => "User", :inverse_of => :frq_sent
	belongs_to :friend_2, :class_name => "User", :inverse_of => :frq_recv
	validates :user, presence: true
	validates :friend, presence: true

	default_scope -> { order(created_at: :desc)}
end
