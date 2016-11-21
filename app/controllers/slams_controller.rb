class SlamsController < ApplicationController
	before_action :logged_in_user , only: [:view]
	def view
		@ques = Question.all
		@f_id = params[:id]
		@user = current_user
		@name = UserProfile.find(@f_id)
		@dp = Blob.find(@name.profile_pic)
		@slam = Slam.find_by(:filled_by => @user.u_id,:filled_for => @f_id)
		if !@slam.nil?
			@answer=SlamQuest.find_by_sql("select * from slam_quests as s ,questions as q where s.q_id=q.q_id and s.slam_id='"+@slam.slam_id+"';")
			
		end
	end

	def view_ans
		@ques = Question.all
		@f1_id = params[:id]
		@user = current_user
		@f2_id = @user
		@name = UserProfile.find(@f1_id)
		@dp = Blob.find(@name.profile_pic)
		@check= 0
		@slam = Slam.find_by(:filled_by => @f1_id,:filled_for => @f2_id)
		if !@slam.nil?
			@check=1
			@answer=SlamQuest.find_by_sql("select * from slam_quests as s, questions as q where s.q_id=q.q_id and s.slam_id='"+@slam.slam_id+"';")
		end
	end

	def ans_view
		@ques = Question.all
		@f2_id = params[:id]
		@user = current_user
		@f1_id = @user
		@name = UserProfile.find(@f2_id)
		@dp = Blob.find(@name.profile_pic)
		@check= 0	
		@slam = Slam.find_by(:filled_by => @f1_id,:filled_for => @f2_id)
		if !@slam.nil?
			@check=1
			@answer=SlamQuest.find_by_sql("select * from slam_quests as s , questions as q where s.q_id=q.q_id and s.slam_id='"+@slam.slam_id+"';")
		end
	end


	def slam_create
		@ques = Question.all
		@user = current_user
		@f_id = params[:new_slam][:fr_id]
		puts params[:new_slam][:fr_id]
		@slam = Slam.find_by(:filled_by => @user.u_id ,:filled_for => @f_id)

		if !@slam.nil?
			@entry=SlamQuest.find_by(:slam_id => @slam.slam_id,:q_id => params[:new_slam][:q_id])
			if @entry.nil?
				@new_entry = SlamQuest.new
				@new_entry.slam_id = @slam.slam_id
				@new_entry.q_id = params[:new_slam][:q_id]
				@new_entry.answer = params[:new_slam][:a]
				if @new_entry.save
					msg={:qdone_id => params[:new_slam][:q_id]}
					render :json => msg
				else 
					msg={:error => "fu"}
					render :json => msg	
				end
		
			else
				@entry.answer = params[:new_slam][:a]
				if @entry.save
					msg={:qdone_id => params[:new_slam][:q_id]}
					render :json => msg
				else 
					msg={:error => "fu"}
					render :json => msg	
				end
			end

		else 
			@new_entry1=Slam.new
			@count = Slam.count.to_s(36)
			@new_entry1.slam_id = @count
			@new_entry1.filled_by = current_user.u_id
			@new_entry1.filled_for = @f_id
			if @new_entry1.save
				###create notifications
				@not = Notification.new
				cnt = Notification.count.to_s(36)
				@not.not_id = cnt
				@not.slam_id = @count
				@not.content = "filled your slam"
				
				if @not.save	#if successfully saved, create notify to
					@notify = NotifyTo.new
					@notify.not_id = cnt
					@notify.from_id = @user.u_id
					@notify.to_id = @f_id
					@notify.status = "N"		#not sent
					@notify.save
				end
				###created notification

				@new_entry=SlamQuest.new
				@new_entry.slam_id = @count
				@new_entry.q_id = params[:new_slam][:q_id]
				@new_entry.answer = params[:new_slam][:a]
				if @new_entry.save
					msg={:qdone_id => params[:new_slam][:q_id]}
					render :json => msg
				else
					msg={:error => "fu"}
					render :json => msg	
				end
			else
				msg={:error => "fu"}
				render :json => msg	
			end
		end
				
	end

	
end
