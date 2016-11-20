class SlamsController < ApplicationController
	before_action :logged_in_user , only: [:view]
	def view
		@ques = Question.all
		@f_id = params[:friend_id]
	end

	def send_post
		@newPost = current_user.own_posts.build(post_params)
		@newPost.p_id = Post.count.to_s(36)

		if @newPost.save
			flash[:notice] = "Posted Succesfully"
			msg = {:value => "ok"}
			render :json => msg
		else
			flash[:notice] = "Error!, try again"
			msg = {:value => "err"}
			render :json => msg
		end
	end

	def post_params
	end

end
