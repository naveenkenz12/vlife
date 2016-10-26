class MessagesController < ApplicationController
	before_action :logged_in_user , only: [:show_message, :send_message]

	def show_message
		#@user = user id of current request
		@user = current_user.u_id
		#@friend = id of friend in between message is to be sent
		@friend = params[:friend]

		#top 10 messages order by desc time
		@message_between = (Message.where(:sender => @user, :receiver => @friend).or(
							Message.where(:sender => @friend, :receiver => @user))).limit(10)

		#sorted in desc by time
		#should be done opp while showing
		@message_content = @message_between.pluck("content", "med_id", "sender")

		render :json => @message_content
	end

	def send_message
		
	end
end