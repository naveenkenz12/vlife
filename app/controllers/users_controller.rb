class UsersController < ApplicationController
  before_action :logged_in_user , only: [:save_online]
  def new
    if logged_in?
      redirect_to home_url
    else
      @user = User.new
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:notice] = "You signed up successfully"
  		flash[:color] = "valid"
      redirect_to '/home'
  	else
  		flash[:notice] = "Bad username and password, Sign Up Again!"
  		flash[:color] = "invalid"
  	  redirect_to root_url
    end
  	
  end

  def user_params
    params.require(:user).permit(:u_id, :email, :phone_no, :password, :password_confirmation, :salt)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please Log In"
      redirect_to login_url
    end
  end


  def correct_user
    @user = User.find(params[:u_id])
    redirect_to(root_url) unless current_user?
  end

  def save_online
    dt = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    User.find(current_user.u_id).update(:last_online => dt)

    @user = current_user
        
    #no sql injection possible here as no term is taken as input from user
    @total_friends = Friend.find_by_sql("select user_id as frn from friends where friend_id = '" + current_user.u_id +
   "' and status = 'accepted' union select friend_id as frn from friends where user_id = '"+ current_user.u_id + "' and "+
   " status = 'accepted' ")

    @total_friends = @total_friends.pluck(:frn)

    @all_friends = []
    for @u in @total_friends
      @ur = User.find(@u)
      x = @ur.last_online
      if !x.blank?
        if Time.now()+330*60-x <= 120  #adjusting timezone 
          @all_friends.push(@ur.u_id)
        end
      end
    end
    puts @all_friends
    @prof = []
    @name_fr = []
    @dp_fr = []
    for @u in @all_friends
      @prof.push(UserProfile.select(:first_name, :middle_name,:last_name,:profile_pic).find_by(:u_id => @u))
    end

    for @u in @prof
      @dp_fr.push(Blob.select(:med_id).find_by(med_id: @u.profile_pic))
    end

    @name_fr = @prof.pluck(:first_name, :middle_name, :last_name)
    #insert dp also
    @all_friends = @all_friends.zip(@name_fr, @dp_fr)
    msg = {:status => "ok", :value => @all_friends}
    render :json => msg
  end

end
