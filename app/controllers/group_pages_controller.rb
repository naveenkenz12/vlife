class GroupPagesController < ApplicationController

	before_action :logged_in_user, only: [:get_page, :search_group, :current_groups, :create_new_group_page, :approve_member_to_group, :invite_member_to_group, :send_request_to_group]

	def current_groups
		@user = current_user

		@all_groups = GroupUser.where(:u_id => current_user.u_id, :status => 'A')
		@count_groups = @all_groups.count()

		@all_joined = GroupUser.where(:u_id => current_user.u_id, :status => 'J')
		@count_joined = @all_joined.count()

		@all_requested = GroupUser.where(:u_id => current_user.u_id, :status => 'P')
		@count_requested = @all_requested.count()

		@all_invited = GroupUser.where(:u_id => current_user.u_id, :status => 'I')
		@count_invited = @all_invited.count()

	end

	def search_group
		groups = GroupPage.where('lower(name) like ?',params[:search_group][:term].downcase+'%').pluck(:name, :page_id)
		render :json => groups.as_json
	end

	def get_page
		puts params[:page_id]
		@user = current_user
		@blob = Blob.new
		@name = GroupPage.find_by(:page_id => params[:page_id]).name
	end

	#function to create a new group page
	def create_new_group_page
		#new group page
		@ngp = GroupPage.new
		cnt = GroupPage.count.to_s(36)
		@ngp.page_id = cnt
		@ngp.description = params[:new_grp][:description]
		@ngp.name = params[:new_grp][:name]
		@ngp.save

		#make the creater admin of the group by default
		@grpu = GroupUser.new
		@grpu.page_id = cnt
		@grpu.u_id = current_user.u_id
		@grpu.status = "A"
		@grpu.save
	end

	#can be approved join request by admin only
	def approve_member_to_group
		@ogr = GroupUser.find_by(:u_id => current_user.u_id, :status => "A", :page_id => params[:new_app][:page_id])
		if !@ogr.nil?
			GroupUser.find_by(:u_id => params[:new_app][:u_id], :page_id => params[:new_app][:page_id], :status => "P").update(:status => "J")
		end
	end

	#invite new member to group, admin can invite
	def invite_member_to_group
		@ogr = GroupUser.find_by(:u_id => current_user.u_id, :status => "A", :page_id => params[:new_inv][:page_id])
		if !@ogr.nil?		#group page exist and inviter in an admin, then continue
			@grpu = GroupUser.new
			@grpu.u_id = params[:new_inv][:u_id]
			@grpu.page_id = params[:new_inv][:page_id]
			@grpu.status = "I"
			@grpu.save
		end
	end

	#send request to be added to a group
	def send_request_to_group
		@grpu = GroupUser.new
		@grpu.page_id = params[:new_req][:page_id]
		@grpu.u_id = current_user.u_id
		@grpu.status = "P"
		@grpu.save
	end

	#accpted to user to join the group, admin can send invitation
	def accept_invite_to_group
		GroupUser.find_by(:u_id => current_user.u_id, :page_id => params[:new_acc][:page_id], :status => "I").update(:status => "J")
	end

end
