class FriendsController < ApplicationController
	before_action :logged_in_user , only: [:show_message, :send_message]

	def show_message
		#@user = user id of current request
		@user = current_user.u_id
		#@friend = id of friend in between message is to be sent
		@friend = parmas[:friend]

		#@message_between = Message.where(:)
	end

	def send_message

	end
end