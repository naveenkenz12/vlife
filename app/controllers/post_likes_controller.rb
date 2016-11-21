class PostLikesController < ApplicationController
	before_action :logged_in_user , only: [:create]

	def create
		@newLike = current_user.like.build(post_params)
		
		if @newLike.save
			###notification for comment based on parent_id
			#do not create notification if owner of post is liking on same post
			@ps = Post.find_by(:p_id => params[:post_like][:p_id])
			if @ps.posted_by_id!=current_user.u_id
				@ont = Notification.find_by(:p_id => @newLike.p_id, :content => "liked your post")
				if @ont.nil?
					@not = Notification.new
					cnt = Notification.count.to_s(36)
					@not.not_id = cnt
				else
					cnt = @ont.not_id
				end
				if @ont.nil?
					@not.p_id = @newLike.p_id
					@not.content = "liked your post"
					@not.save
				end
				@notify = NotifyTo.new
				@notify.not_id = cnt
				@notify.from_id = current_user.u_id
				#to id is the owner of post
				
				@notify.to_id = @ps.posted_by_id
				@notify.status = "N"		#not sent
				@notify.save
			end
			###created notification
			flash[:success] = "Like"
			msg = {:value => "ok"}
			render :json => msg
		else
			flash[:info] = "Could Not Like"
			msg = {:value => "err"}
			render :json => msg
		end
	end

	def delete
		if PostLike.delete_all "(p_id = '"+params[:post_unlike][:p_id]+"' AND u_id= '"+current_user.u_id+"')"
			flash[:success] = "UnLike"
			#notification
			@ps = Post.find_by(:p_id => params[:post_unlike][:p_id])
			@ont = Notification.find_by(:p_id => params[:post_unlike][:p_id], :content => "liked your post")
			if !@ont.nil?
				NotifyTo.find_by(:not_id => @ont.not_id, :from_id => current_user.u_id, :to_id => @ps.posted_by_id).delete
			end
			#notification
			msg = {:value => "ok"}
			render :json => msg
		else
			flash[:info] = "Could Not UnLike"
			msg = {:value => "err"}
			render :json => msg
		end
	end

	def post_params
		params.require(:post_like).permit(:p_id)
	end

end
