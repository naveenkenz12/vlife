class CommentsController < ApplicationController
	before_action :logged_in_user , only: [:create, :destroy]
	
	def create
		@new_comment = current_user.own_posts.build(comment_params)
		@new_comment.p_id = Post.count.to_s(36)
		puts @new_comment.parent_id
		puts @new_comment.p_id
		puts @new_comment.posted_by_id
		if @new_comment.save
			flash[:notice] = "Commenetd Succesfully"
			msg = {:status => "ok"}
			render :json => msg
		else
			flash[:notice] = "Error!, try again"
			msg = {:status => "err"}
			render :json => msg
		end

	end

	private
		def comment_params
			params.require(:comment).permit(:content, :parent_id)
		end
end