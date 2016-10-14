class Message < ApplicationRecord
	belongs_to :sent_by, :class_name => "User", :inverse_of => :sent_messages
	belongs_to :sent_to, :class_name => "User", :inverse_of => :received_messages
	validates :sender, presence: true
	validates :receiver, presence: true
	validates :content, length: {maximum: 160}

	default_scope -> { order(created_at: :desc)}
end
