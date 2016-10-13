class FriendsController < ApplicationController
	before_action :logged_in_user , only: [:show_acceptd, :send_request]
	#all friends which are accepted only
	#status = accepted

	def show_accepted
	  	@user = current_user
  	  	
  	  	@all_friends = Friend.find_by_sql("select user as frn from friends where friend = '" + current_user.u_id +
  	   "' and status = 'accepted' union select friend as frn from friends where user = '"+ current_user.u_id + "' and "+
  	   " status = 'accepted' ")
  	  	@count_friends = @all_friends.count()
  	  	
  	  	@all_followings = Friend.find_by_sql("select friend as frn from friends where user = '"+ current_user.u_id + "' and "+
  	   " status = 'following' ")
		@count_followings = @all_followings.count()

  	  	@all_requests = Friend.find_by_sql("select user as frn from friends where  friend = '"+ current_user.u_id + "' and "+
  	   " status = 'waiting' ")
		@count_requests = @all_requests.count()
	end

	def send_request
		@newFriend = current_user.frq_sent.build(friend_params)
		@newFriend.user = current_user.u_id
		@newFriend.status = 'waiting'
		if @newFriend.save
			flash[:notice] = "Friend Request Sent"
			msg = {:status => "ok"}
			render :json => msg
		else
			flash[:notice] = "Error!, try again"
			msg = {:status => "err"}
			render :json => msg
		end
	end

	def delete_friend
	end

	def search_friend

	end

	def friend_params
		params.require(:comment).permit(:friend)
	end

end