class GroupPagesController < ApplicationController

	before_action :logged_in_user, only: [:remove_member_from_group, :members, :members_requested, :members_invited, :get_page, :search_group, :current_groups, :create_new_group_page, :approve_member_to_group, :invite_member_to_group, :send_request_to_group]

	def current_groups
		@user = current_user

		@all_groups = GroupUser.where(:u_id => current_user.u_id, :status => 'A')
		@count_groups = @all_groups.count()

		@all_groups = @all_groups.pluck(:page_id)
		@prof = []
		@total_members = []
		@mutual_members = []

		for @u in @all_groups
			@prof.push(GroupPage.find_by(:page_id => @u))
		end
		@dp = []
		for @u in @prof
			@dp.push(Blob.find_by(med_id: @u.page_pic))
			@total_members.push(GroupUser.where(:page_id => @u.page_id).count())
			@mutual_members.push(GroupUser.find_by_sql("select * from group_users where page_id = '"+@u.page_id + "'and u_id in (select user_id as u_id from friends where friend_id = '"+current_user.u_id+"' and status = 'accepted' union select friend_id as u_id from friends where user_id = '"+current_user.u_id+"' and status = 'accepted' )").count())
		end



		@prof = @prof.pluck(:name, :description)

		@all_groups = @all_groups.zip(@prof, @dp, @total_members, @mutual_members)



		@all_joined = GroupUser.where(:u_id => current_user.u_id, :status => 'J')
		@count_joined = @all_joined.count()

		@all_joined = @all_joined.pluck(:page_id)
		@prof = []
		@total_members = []
		@mutual_members = []
		for @u in @all_joined
			@prof.push(GroupPage.find_by(:page_id => @u))
		end
		@dp = []
		for @u in @prof
			@dp.push(Blob.find_by(med_id: @u.page_pic))
			@total_members.push(GroupUser.where(:page_id => @u.page_id).count())
			@mutual_members.push(GroupUser.find_by_sql("select * from group_users where page_id = '"+@u.page_id + "'and u_id in (select user_id as u_id from friends where friend_id = '"+current_user.u_id+"' and status = 'accepted' union select friend_id as u_id from friends where user_id = '"+current_user.u_id+"' and status = 'accepted' )").count())
		end



		@prof = @prof.pluck(:name, :description)

		@all_joined = @all_joined.zip(@prof, @dp, @total_members, @mutual_members)



		@all_requested = GroupUser.where(:u_id => current_user.u_id, :status => 'P')
		@count_requested = @all_requested.count()

		@all_requested = @all_requested.pluck(:page_id)
		@prof = []
		@total_members = []
		@mutual_members = []
		for @u in @all_requested
			@prof.push(GroupPage.find_by(:page_id => @u))
		end
		@dp = []
		for @u in @prof
			@dp.push(Blob.find_by(med_id: @u.page_pic))
			@total_members.push(GroupUser.where(:page_id => @u.page_id).count())
			@mutual_members.push(GroupUser.find_by_sql("select * from group_users where page_id = '"+@u.page_id + "'and u_id in (select user_id as u_id from friends where friend_id = '"+current_user.u_id+"' and status = 'accepted' union select friend_id as u_id from friends where user_id = '"+current_user.u_id+"' and status = 'accepted' )").count())
		end



		@prof = @prof.pluck(:name, :description)

		@all_requested = @all_requested.zip(@prof, @dp, @total_members, @mutual_members)




		@all_invited = GroupUser.where(:u_id => current_user.u_id, :status => 'I')
		@count_invited = @all_invited.count()

		@all_invited = @all_invited.pluck(:page_id)
		@prof = []
		for @u in @all_invited
			@prof.push(GroupPage.find_by(:page_id => @u))
		end
		@dp = []
		@total_members = []
		@mutual_members = []
		for @u in @prof
			@dp.push(Blob.find_by(med_id: @u.page_pic))
			@total_members.push(GroupUser.where(:page_id => @u.page_id).count())
			@mutual_members.push(GroupUser.find_by_sql("select * from group_users where page_id = '"+@u.page_id + "'and u_id in (select user_id as u_id from friends where friend_id = '"+current_user.u_id+"' and status = 'accepted' union select friend_id as u_id from friends where user_id = '"+current_user.u_id+"' and status = 'accepted' )").count())
		end



		@prof = @prof.pluck(:name, :description)

		@all_invited = @all_invited.zip(@prof, @dp, @total_members, @mutual_members)

	end

	def search_group
		groups = GroupPage.where('lower(name) like ?',params[:search_group][:term].downcase+'%').pluck(:name, :page_id)
		render :json => groups.as_json
	end

	def search_inv
		groups = User.find_by_sql("select u_id from users where  u_id like '"+params[:search_inv][:term].downcase+"%'").pluck(:u_id)
		render :json => groups.as_json
	end

	def get_page
		@user = current_user

		@newPost = current_user.own_posts.build

		@posts = Post.where("posts.parent_id is NULL and posts.page_id = ?", params[:page_id])
		@admin = GroupUser.find_by(:page_id => params[:page_id], :u_id => current_user.u_id, :status => "A")
		@blob = Blob.new
		@page = GroupPage.find_by(:page_id => params[:page_id])
		if @page.nil?
			redirect_to '/'+current_user.u_id+'/groups'
		end
		@dp = @page.page_pic
		@userprofile = UserProfile.find_by(:u_id => current_user.u_id)
		if @userprofile.nil?
			redirect_to '/'
		end
		@cp = @userprofile.profile_pic

		if !@dp.nil?
			@dp = Blob.find_by(:med_id => @dp)
		end

		if !@cp.nil?
			@cp = Blob.find_by(:med_id => @cp)
		end 

		ps = GroupUser.find_by(:page_id => params[:page_id], :u_id => current_user.u_id)
		if ps.nil?
			@status = "N"
		else
			@status = ps.status
		end

	end

	#function to create a new group page
	def create_new_group_page
		#new group page
		@ngp = GroupPage.new
		cnt = GroupPage.count.to_s(36)
		@ngp.page_id = cnt
		@ngp.description = params[:new_grp][:description]
		@ngp.name = params[:new_grp][:name]

		if @ngp.save
			#make the creater admin of the group by default
			@grpu = GroupUser.new
			@grpu.page_id = cnt
			@grpu.u_id = current_user.u_id
			@grpu.status = "A"
			if @grpu.save
				redirect_to '/group/?page_id='+cnt
			end
		end
	end

	#can be approved join request by admin only
	def approve_member_to_group
		@ogr = GroupUser.find_by(:u_id => current_user.u_id, :status => "A", :page_id => params[:req][:page_id])
		if !@ogr.nil?
			@gru = GroupUser.find_by(:u_id => params[:req][:u_id], :page_id => params[:req][:page_id], :status => "P")
		end
		if @gru.update(:status => "J")
			msg = {:button_value => "Added, Click to Remove", :action_value => "remove_member_from_group"}
			render :json => msg
		else
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	#invite new member to group, admin can invite
	def invite_member_to_group
		@ogr = GroupUser.find_by(:u_id => current_user.u_id, :status => "A", :page_id => params[:req][:page_id])
		if !@ogr.nil?		#group page exist and inviter in an admin, then continue
			@grpu = GroupUser.new
			@grpu.u_id = params[:req][:u_id]
			@grpu.page_id = params[:req][:page_id]
			@grpu.status = "I"
			if @grpu.save
				msg = {:button_value => "Invited", :action_value => "invited"}
				render :json => msg
			else
				msg = {:button_value => "", :action_value => ""}
				render :json => msg
			end
		end
	end

	def remove_member_from_group
		@ogr = GroupUser.find_by(:u_id => current_user.u_id, :status => "A", :page_id => params[:req][:page_id])
		if !@ogr.nil?
			@gru = GroupUser.find_by(:u_id => params[:req][:u_id], :page_id => params[:req][:page_id])
			if @gru.delete
				msg = {:button_value => "Invite", :action_value => "invite_member_to_group"}
				render :json => msg
			else
				msg = {:button_value => "", :action_value => ""}
				render :json => msg
			end
		end
	end

	#send request to be added to a group
	def send_request_to_group
		@grpu = GroupUser.new
		@grpu.page_id = params[:req][:page_id]
		@grpu.u_id = current_user.u_id
		@grpu.status = "P"
			
		if @grpu.save
			msg = {:button_value => "Waiting", :action_value => "cancel_request_to_group"}
			render :json => msg
		else
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	#accpted to user to join the group, admin can send invitation
	def accept_invite_to_group
		if GroupUser.find_by(:u_id => current_user.u_id, :page_id => params[:req][:page_id], :status => "I").update(:status => "J")
			msg = {:button_value => "Joined, Click to Unjoin", :action_value => "delete_user_from_group"}
			render :json => msg
		else
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	def cancel_request_to_group
		if GroupUser.find_by(:page_id => params[:req][:page_id], :u_id => current_user.u_id).delete()
			msg = {:button_value => "Canceled, Click to Join", :action_value => "send_request_to_group"}
			render :json => msg
		else
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	def delete_user_from_group
		if GroupUser.find_by(:page_id => params[:req][:page_id], :u_id => current_user.u_id).delete()
			msg = {:button_value => "Click to Join", :action_value => "send_request_to_group"}
			render :json => msg
		else
			msg = {:button_value => "", :action_value => ""}
			render :json => msg
		end
	end

	def memb
		@user = current_user
		@blob = Blob.new
		@page_id = params[:search_inv][:page_id]
		@page = GroupPage.find_by(:page_id => @page_id)
		@newPost = current_user.own_posts.build

		@dp = @page.page_pic
		@userprofile = UserProfile.find_by(:u_id => current_user.u_id)
		if @userprofile.nil?
			redirect_to '/'
		end
		@cp = @userprofile.profile_pic

		if !@dp.nil?
			@dp = Blob.find_by(:med_id => @dp)
		end

		if !@cp.nil?
			@cp = Blob.find_by(:med_id => @cp)
		end

		ps = GroupUser.find_by(:page_id => params[:page_id], :u_id => current_user.u_id)
		if ps.nil?
			@status = "N"
		else
			@status = ps.status
		end


		@admin = GroupUser.find_by(:page_id => params[:page_id], :u_id => current_user.u_id, :status => "A")
		if !@admin.nil?
			@admin = 'l'
		end
		@all_members = User.where('lower(u_id) like ?',params[:search_inv][:term].downcase+'%').pluck(:u_id)-GroupUser.where(:page_id => @page_id).pluck(:u_id)

		@count_members = @all_members.count()

  	  	#@all_members = @all_members.pluck(:u_id)
  	  	@prof = []
  	  	@name_fr = []
  	  	@location_fr = []
  	  	@dp_fr = []
  	  	for @u in @all_members
  	  		@prof.push(UserProfile.find_by(:u_id => @u))
  	  	end

  	  	for @u in @prof
  	  		@dp_fr.push(Blob.find_by(med_id: @u.profile_pic))
  	  	end

  	  	@name_fr = @prof.pluck(:first_name, :middle_name, :last_name)
  	  	@location_fr = @prof.pluck(:city, :state, :country)
  	  	#insert dp also

  	  	@all_members = @all_members.zip(@name_fr, @location_fr, @dp_fr)
	end

	def members
		@user = current_user
		@blob = Blob.new
		@page_id = params[:page_id]
		@page = GroupPage.find_by(:page_id => @page_id)
		@newPost = current_user.own_posts.build

		@dp = @page.page_pic
		@userprofile = UserProfile.find_by(:u_id => current_user.u_id)
		if @userprofile.nil?
			redirect_to '/'
		end
		@cp = @userprofile.profile_pic

		if !@dp.nil?
			@dp = Blob.find_by(:med_id => @dp)
		end

		if !@cp.nil?
			@cp = Blob.find_by(:med_id => @cp)
		end

		@q = params[:q]

		ps = GroupUser.find_by(:page_id => params[:page_id], :u_id => current_user.u_id)
		if ps.nil?
			@status = "N"
		else
			@status = ps.status
		end

		#if the user is admin of this group
		@admin = GroupUser.find_by(:page_id => params[:page_id], :u_id => current_user.u_id, :status => "A")

		if @q=='m'
			if !@admin.nil?
				@admin = 'm'
			end
			@all_members = (GroupUser.where(:page_id => @page_id, :status => "A")+GroupUser.where(:page_id => @page_id, :status => "J"))
		elsif @q=='r'
			if !@admin.nil?
				@admin = 'r'
			end
			@all_members = GroupUser.where(:page_id => @page_id, :status => "P")
		elsif @q=='i'
			if !@admin.nil?
				@admin = 'i'
			end
			@all_members = GroupUser.where(:page_id => @page_id, :status => "I")
		else
			redirect_to :back
		end

  	  	@count_members = @all_members.count()

  	  	@all_members = @all_members.pluck(:u_id)
  	  	@prof = []
  	  	@name_fr = []
  	  	@location_fr = []
  	  	@dp_fr = []
  	  	for @u in @all_members
  	  		@prof.push(UserProfile.find_by(:u_id => @u))
  	  	end

  	  	for @u in @prof
  	  		@dp_fr.push(Blob.find_by(med_id: @u.profile_pic))
  	  	end

  	  	@name_fr = @prof.pluck(:first_name, :middle_name, :last_name)
  	  	@location_fr = @prof.pluck(:city, :state, :country)
  	  	#insert dp also

  	  	@all_members = @all_members.zip(@name_fr, @location_fr, @dp_fr)


  	  	
	end

end
