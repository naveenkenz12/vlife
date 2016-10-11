class Post < ApplicationRecord
	belongs_to :user, foreign_key: "posted_by_id"
	validates :posted_by_id, presence: true
	validates :content, presence: true, length: {maximum: 160}

	default_scope -> { order(created_at: :desc)}
end
