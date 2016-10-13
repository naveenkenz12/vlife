class FriendsController < ApplicationController
	before_action :logged_in_user , only: [:show_acceptd, :send_request]
	#all friends which are accepted only
	#status = accepted

	def show_accepted
	  @user = current_user
  	  @all_friends = Friend.find_by_sql("select user as frn from friends where friend = '" + current_user.u_id +
  	   "' union select friend as frn from friends where user = '"+ current_user.u_id + "'")

  	  puts @all_friends
	end

	def send_request
		@newFriend = current_user.frq_sent.build(post_params)
	end

	def post_params
		#params.require(:comment).permit(:content, :parent_id)
	end

end