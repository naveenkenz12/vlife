class CommentsController < ApplicationController
	before_action :logged_in_user , only: [:create, :destroy, :get]
	
	def create
		@new_comment = current_user.own_posts.build(comment_params)
		@new_comment.p_id = Post.count.to_s(36)
		if @new_comment.save
			flash[:notice] = "Commenetd Succesfully"
			render :json => @new_comment.as_json
		else
			flash[:notice] = "Error!, try again"
			msg = {:status => "Error ! Please Try Again"}
			render :json => msg
		end

	end

	def get

		comments = Post.where(parent_id: params[:secid]);
		render :json => comments.as_json
	end

	private
		def comment_params
			params.require(:comment).permit(:content, :parent_id)
		end
end