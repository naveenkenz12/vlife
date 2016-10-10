class SessionsController < ApplicationController
	def create
		user = User.find_by(u_id: params[:session][:u_id])
		puts user
		if user && user.authenticate(params[:session][:password])
			log_in user
			remember user
			redirect_to '/home'
		else
			flash.now[:danger] = 'Invalid UserID/Password'
			redirect_to root_url
		end	
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end
