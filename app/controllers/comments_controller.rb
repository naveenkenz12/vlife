class CommentsController < ApplicationController
	before_action :logged_in_user , only: [:create, :destroy, :get]
	
	def create
		@new_comment = current_user.own_posts.build(comment_params)
		@new_comment.p_id = Post.count.to_s(36)
		if @new_comment.save
			###notification for comment based on parent_id
			#do not create notification if owner of post is commenting on same post
			@ps = Post.find_by(:p_id => params[:comment][:parent_id])
			if @ps.posted_by_id!=current_user.u_id
				@ont = Notification.find_by(:p_id => @new_comment.parent_id, :content => "commented on your post")
				if @ont.nil?
					@not = Notification.new
					cnt = Notification.count.to_s(36)
					@not.not_id = cnt
				else
					cnt = @ont.not_id
				end
				if !params[:comment][:parent_id].blank?	#comment
					if @ont.nil?
						@not.p_id = @new_comment.parent_id
						@not.content = "commented on your post"
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
			end
			###created notification
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
			params.require(:comment).permit(:content, :parent_id, :page_id)
		end
end