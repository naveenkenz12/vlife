class PostController < ApplicationController
	before_action :logged_in_user only: [:create, :destroy]
	def create
		@newPost = current_user.post.build(post_params)
		if @newPost.save
			flash[:success] = "Posted Sucessfully"
			redirect_to home_url
		else
			render home_url
		end
	end

	def post_params
		params.require(:post).permit(:p_id, :content)
	end


end
