class SessionsController < ApplicationController
	def create
		user=User.find_by(u_id: params[:session][:u_id])
		if user && user.authenticate(params[:session][:password])

		else
			flash.now[:danger] = 'Invalid UserID/Password'
			render 'new'
		end	
	end

end
