class PostLike < ApplicationRecord
	belongs_to :liked_post, :class_name => "Post", :inverse_of => "like"
	belongs_to :liked_by, :class_name => "User", :inverse_of => "like"
	validates :p_id, presence: true
	validates :u_id, presence: true


	default_scope -> { order(created_at: :desc)}
end
