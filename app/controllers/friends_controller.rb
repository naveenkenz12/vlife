class FriendsController < ApplicationController
	before_action :logged_in_user , only: [:show_acceptd, :request_f, :cancel_f, :unfriend_f, :accept_f, :search]
	#all friends which are accepted only
	#status = accepted

	def show_accepted
	  	@user = current_user
  	  	
  	  	#no sql injection possible here as no term is taken as input from user
  	  	@all_friends = Friend.find_by_sql("select user_id as frn from friends where friend_id = '" + current_user.u_id +
  	   "' and status = 'accepted' union select friend_id as frn from friends where user_id = '"+ current_user.u_id + "' and "+
  	   " status = 'accepted' ")
  	  	@count_friends = @all_friends.count()

  	  	@all_friends = @all_friends.pluck(:frn)
  	  	@prof = []
  	  	@name_fr = []
  	  	@location_fr = []
  	  	for @u in @all_friends
  	  		@prof.push(UserProfile.find(@u))
  	  	end

  	  	@name_fr = @prof.pluck(:first_name, :middle_name, :last_name)
  	  	@location_fr = @prof.pluck(:city, :state, :country)

  	  	@all_friends = @all_friends.zip(@name_fr, @location_fr)
  	  	
  	  	#following, request sent by user but yet to be accepted(waiting)
  	  	@all_followings = Friend.find_by_sql("select friend_id as frn from friends where user_id = '"+ current_user.u_id + "' and "+
  	   " status = 'waiting' ")
		@count_followings = @all_followings.count()

		@all_followings = @all_followings.pluck(:frn)
  	  	@prof = []
  	  	@name_fol = []
  	  	@location_fol = []
  	  	for @u in @all_followings
  	  		@prof.push(UserProfile.find(@u))
  	  	end

  	  	@name_fol = @prof.pluck(:first_name, :middle_name, :last_name)
  	  	@location_fol = @prof.pluck(:city, :state, :country)

  	  	@all_followings = @all_followings.zip(@name_fol, @location_fol)

  	  	###
  	  	@all_requests = Friend.find_by_sql("select user_id as frn from friends where friend_id = '"+ current_user.u_id + "' and "+
  	   " status = 'waiting' ")
		@count_requests = @all_requests.count()

		@all_requests = @all_requests.pluck(:frn)
  	  	@prof = []
  	  	@name_re = []
  	  	@location_re = []
  	  	for @u in @all_requests
  	  		@prof.push(UserProfile.find(@u))
  	  	end

  	  	@name_re = @prof.pluck(:first_name, :middle_name, :last_name)
  	  	@location_re = @prof.pluck(:city, :state, :country)

  	  	@all_requests = @all_requests.zip(@name_re, @location_re)

	end
	
	#send request
	def request_f
		@newFriend = current_user.frq_sent.build(friend_params)
		@newFriend.status = 'waiting'
		if @newFriend.save
			flash[:notice] = "Friend Request Sent"
			msg = {:button_value => "Friend Request Sent, Click to cancel", :action_value => "cancel_f"}
			render :json => msg
		else
			flash[:notice] = "Error!, try again"
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	#cancel sent request
	def cancel_f
		if Friend.delete_all "user_id = '"+current_user.u_id+"' AND friend_id = '"+params[:req][:friend_id]+"'"
			flash[:notice] = "Friend Request Cancelled"
			msg = {:button_value => "Send Friend Request", :action_value => "request_f"}
			render :json => msg
		elsif 
			flash[:notice] = "Error!, try again"
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	#accept friend request
	def accept_f
		if Friend.where("user_id = ? and friend_id = ?",params[:req][:friend_id], current_user.u_id).update_all(:status => 'accepted')
			flash[:notice] = "Friend Request Accepted"
			msg = {:button_value => "Friend, Click to Unfriend", :action_value => "unfriend_f"}
			render :json => msg
		elsif 
			flash[:notice] = "Error!, try again"
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	#unfriend friend
	def unfriend_f
		if Friend.delete_all "(user_id = '"+current_user.u_id+"' AND friend_id = '"+params[:req][:friend_id]+"') or "+ " (friend_id = '"+current_user.u_id+"' AND user_id = '"+params[:req][:friend_id]+"')"
			flash[:notice] = "Unfriend"
			msg = {:button_value => "Send Friend Request", :action_value => "request_f"}
			render :json => msg
		elsif 
			flash[:notice] = "Error!, try again"
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	def search
		#friends = User.find_by_sql("select u_id from users where u_id like" +" '"+params[:search][:term]+"%'")
		friends = User.where('u_id like ?',params[:search][:term]+'%').pluck(:u_id)
		render :json => friends.as_json
	end

	def friend_params
		params.require(:req).permit(:friend_id)
	end

end