class UserProfilesController < ApplicationController
before_action :logged_in_user, only: [:create ,:edit, :update, :profile]
  
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
      @status = Friend.where(:user => current_user.u_id, :friend => @user.u_id).pluck(:status)
      
      if !@status.blank?
        @status = @status[0];
        if @status=="accepted"
          @status = "cnf"
        elsif @status=="waiting"
          @status = "frs"
        end
      end

      if @status.blank?
        s2 = Friend.where(:user => @user.u_id, :friend => current_user.u_id).pluck(:status)
        @status = @status[0]
        if @status=="accepted"
          @status = "cnf"
        elsif @status=="waiting"
          @status = "afr"
        end
      end

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

  def about
  	
  	@user = User.find_by(u_id: params[:id])
  	if @user.nil?
  		redirect_to '/error'
  	else
  		@profile = UserProfile.find_by(u_id: @user.u_id)	
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
    params.require(:user_profile).permit(:first_name, :last_name, :birthday, :gender,:rel_status)
  end

  
end