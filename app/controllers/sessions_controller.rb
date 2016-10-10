class SessionsController < ApplicationController
	def create
		user = User.find_by(u_id: params[:session][:u_id])
		if user && user.authenticate(params[:session][:password])
			log_in user
			remember user
			redirect_to user
		else
			flash.now[:danger] = 'Invalid UserID/Password'
			render 'new'
		end	
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end
