class PostLikesController < ApplicationController
	before_action :logged_in_user , only: [:create]

	def create
		@newLike = current_user.like.build(post_params)
		
		if @newLike.save
			flash[:success] = "Like"
			msg = {:value => "ok"}
			render :json => msg
		else
			flash[:info] = "Could Not Like"
			msg = {:value => "err"}
			render :json => msg
		end
	end

	def post_params
		params.require(:post_like).permit(:p_id)
	end

end
