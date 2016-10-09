class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    puts "1\n"
    puts user_params
    puts "10\n"
  	if @user.save
      puts "2\n"
  		flash[:notice] = "You signed up successfully"
  		flash[:color] = "valid"
  	else
      puts "3\n"
  		flash[:notice] = "Bad username and password"
  		flash[:color] = "invalid"
  	end
    puts "4\n"
  	render 'new'
    puts "5\n"
  end

  def user_params
    params.require(:user).permit(:u_id, :email, :phone_no, :password, :password_confirmation, :salt)
  end

end
