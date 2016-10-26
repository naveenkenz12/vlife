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
  		flash[:notice] = "Bad username and password"
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

    friends_online = User.find_by_sql("select u_id, last_online from users where ('" + current_user.u_id + "', users.u_id) in (select user_id, friend_id from friends where status = 'accepted') or (users.u_id, '" + current_user.u_id + "') in (select user_id, friend_id from friends where status = 'accepted')")

    msg = {:status => "ok", :value => friends_online}
    render :json => msg
  end

end
