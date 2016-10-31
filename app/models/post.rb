class Post < ApplicationRecord
	belongs_to :posted_by, :class_name => "User", :inverse_of => :own_posts

	has_many :like, :class_name => 'PostLike', :foreign_key => 'p_id', dependent: :destroy,  :inverse_of => :liked_post

	validates :posted_by_id, presence: true
	validates :content, presence: true, length: {maximum: 160}


	default_scope -> { order(created_at: :desc)}
end
