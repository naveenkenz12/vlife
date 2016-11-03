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
		@newMessage = current_user.sent_messages.build(message_params)
		@newMessage.msg_id = Message.count.to_s(36)
		@newMessage.status = "sent"
		if @newMessage.save
			flash[:notice] = "Message Sent"
			msg = {:value => "ok"}
			render :json => msg
		else
			flash[:notice] = "Error!, try again"
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	def new_message
		msg = Message.where(:receiver => current_user.u_id,:status => 'sent').last
		if !msg.nil?
			msg.update(:status => 'delievered')
			js = {:status => "ok", :content => msg.content, :media => msg.med_id, :sender => msg.sender }
			render :json => js
		else
			js = {:status => "err"}
			render :json => js
		end
	end

	def message_params
		params.require(:message).permit(:receiver, :content, :med_id)
	end
end