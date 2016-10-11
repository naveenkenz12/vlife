class UsersController < ApplicationController
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
  	end
  	redirect_to 'new'
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

end
