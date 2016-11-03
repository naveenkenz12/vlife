class SessionsController < ApplicationController
	def create
		user = User.find_by(u_id: params[:session][:u_id])
		puts user
		if user && user.authenticate(params[:session][:password])
			log_in user
			remember user
			@up = UserProfile.find_by(:u_id => user.u_id)
			if @up.blank?
				redirect_to '/'+user.u_id+'/about'
			else
				redirect_to '/home'
			end
		else
			flash[:danger] = 'Invalid UserID/Password'
			redirect_to root_url
		end	
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end
