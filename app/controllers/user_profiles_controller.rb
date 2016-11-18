class UserProfilesController < ApplicationController
before_action :logged_in_user, only: [:create ,:edit, :update, :profile, :update_rel_status]
  
  def profile

  	@user = User.find_by(u_id: params[:id])
  	if @user.nil?
  		redirect_to '/error'
  	else
  		@newPost = current_user.own_posts.build
  		@posts = Post.where(posted_to_id: @user.u_id)
      #a = current user
      #b = user whose profile 
      #already friend 
      #(a,b,accepted) or (b,a,accepted) should be in table

      #friend request sent
      #(a,b,waiting) is in tablee

      #accept friend request 
      #(b,a,waiting) is in table

      #send friend request
      #else
      @status = Friend.where(:user_id => current_user.u_id, :friend_id => @user.u_id).pluck(:status)
      
      if !@status.blank?
        @status = @status[0];
        if @status=="accepted"
          @status = "cnf"
        elsif @status=="waiting"
          @status = "frs"
        end
      end

      if @status.blank?
        @status = Friend.where(:user_id => @user.u_id, :friend_id => current_user.u_id).pluck(:status)
        @status = @status[0]
        if @status=="accepted"
          @status = "cnf"
        elsif @status=="waiting"
          @status = "afr"
        end
      end
      @userprofile = UserProfile.find_by(:u_id => @user.u_id)
      #get the profile picture of user
      @dp = nil
      if !@userprofile.blank?
        @dp = Blob.find_by(med_id: @userprofile.profile_pic)
      end
      @blob = Blob.new
  	end
  end
  
  def create
  	  if UserProfile.find_by(u_id: current_user.u_id).nil?
          @newProfile = current_user.build_profile(post_params)
          if @newProfile.save
            flash[:notice] = "Profile Created Successfully"
            redirect_to '/'+current_user.u_id+'/about'
          end
      else
          flash[:danger] = "Something Went Wrong"
        redirect_to '/error'
      end
  end

  def update_rel_status
    if UserProfile.find_by(:u_id => current_user.u_id).update_all(:rel_status => params[:req][:rel_status])
      msg = {:status => 'ok' }
      render :json => msg
    else
      msg = {:status => 'err' }
      render :json => msg
  end

  def about
  	@blob = Blob.new
  	@user = User.find_by(u_id: params[:id])
  	if @user.nil?
  		redirect_to '/error'
  	else
  		@profile = UserProfile.find_by(u_id: @user.u_id)	
      if !@profile.blank?
        @dp = Blob.find_by(med_id: @profile.profile_pic)
      end
  		if @profile.nil? and @user.u_id == current_user.u_id
  			@newProfile = current_user.build_profile
  		end
  	end
  	
  end
  

  def edit
    @user=current_user
  end

  def update
    
  end


  def post_params
    params.require(:user_profile).permit(:first_name, :middle_name, :last_name, 
      :birthday, :gender, :language, :rel_status, :country, :state, :city)
  end

  
end