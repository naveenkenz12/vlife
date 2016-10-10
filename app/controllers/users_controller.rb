class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:notice] = "You signed up successfully"
  		flash[:color] = "valid"
      redirect_to @user
  	else
  		flash[:notice] = "Bad username and password"
  		flash[:color] = "invalid"
  	end
  	render 'new'
  end

  def user_params
    puts :u_id
    puts :password
    puts :password_confirmation
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
