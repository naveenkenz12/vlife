class Post < ApplicationRecord
	belongs_to :posted_by, :class_name => "User", :inverse_of => :own_posts
	validates :posted_by_id, presence: true
	validates :content, presence: true, length: {maximum: 160}

	belongs_to :posted_to, :class_name => "User", :inverse_of => :user_posts

	default_scope -> { order(created_at: :desc)}
end
