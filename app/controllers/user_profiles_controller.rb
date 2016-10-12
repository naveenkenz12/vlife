class UserProfilesController < ApplicationController
before_action :logged_in_user, only: [:create ,:edit, :update, :profile]
  
  def profile

  	@user = User.find_by(u_id: params[:id])
  	if @user.nil?
  		redirect_to '/error'
  	else
  		@newPost = current_user.user_posts.build
  		@posts = Post.where(posted_to_id: @user.u_id)
  	end
  end
  
  def create
  	  if UserProfile.find_by(u_id: current_user.u_id).nil?
          @newProfile = current_user.build_profile(post_params)
          if @newProfile.save
            flash[:notice] = "Profile Created Successfully"
            redirect_to '/current_user.u_id/about'
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