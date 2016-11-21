class PostsController < ApplicationController
	before_action :logged_in_user , only: [:create, :destroy]
	def create
		@newPost = current_user.own_posts.build(post_params)
		@newPost.p_id = Post.count.to_s(36)

		if @newPost.save
			###notification for post / comment based on parent_id
			@not = Notification.new
			cnt = Notification.count.to_s(36)
			@not.not_id = cnt
			if !params[:post][:page_id].blank?	#posted to group
				@not.page_id = params[:post][:page_id]
				@not.p_id = @newPost.p_id
				@not.content = "posted in group"
				if @not.save	#if successfully saved, create notify to
					@all_members = GroupUser.where(:page_id => params[:post][:page_id])
					@all_members = @all_members.pluck(:u_id)
					for @u in @all_members
						@notify = NotifyTo.new
						@notify.not_id = cnt
						@notify.from_id = current_user.u_id
						@notify.to_id = @u
						@notify.status = "N"		#not sent
						@notify.save
					end
				end
			elsif !params[:post][:posted_to_id].blank?	#posted on timeline
				@not.p_id = @newPost.p_id
				@not.content = "posted on your timeline"
				if @not.save	#if successfully saved, create notify to
					@notify = NotifyTo.new
					@notify.not_id = cnt
					@notify.from_id = current_user.u_id
					@notify.to_id = params[:post][:posted_to_id]
					@notify.status = "N"		#not sent
					@notify.save
				end
			end
			###created notification

			flash[:success] = "Posted Sucessfully"
			redirect_to :back
		else
			flash[:info] = "Could Not Post"
			redirect_to :back
		end
	end

	def send_post
		@newPost = current_user.own_posts.build(post_params)
		@newPost.p_id = Post.count.to_s(36)

		if @newPost.save
			###notification for post / comment based on parent_id
			@not = Notification.new
			cnt = Notification.count.to_s(36)
			@not.not_id = cnt
			if !params[:post][:posted_to_id].blank?	#posted on timeline
				@not.p_id = @newPost.p_id
				@not.content = "posted on your timeline"
				if @not.save	#if successfully saved, create notify to
					@notify = NotifyTo.new
					@notify.not_id = cnt
					@notify.from_id = current_user.u_id
					@notify.to_id = params[:post][:posted_to_id]
					@notify.status = "N"		#not sent
					@notify.save
				end
			end
			###created notification
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
		params.require(:post).permit(:content, :posted_to_id, :parent_id, :page_id)
	end

end
