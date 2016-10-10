module SessionsHelper
	def log_in(user)
		session[:u_id] = user.id
	end
end
