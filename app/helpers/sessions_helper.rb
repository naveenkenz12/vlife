module SessionsHelper
	#login user
	def log_in(user)
		session[:u_id] = user.u_id
		#session[:email] = user.email
		#session[:phone_no] = user.phone_no
	end

	#remember user
	def remember(user)
		user.remember
		cookies.permanent.signed[:u_id] = user.u_id
		#cookies.permanent.signed[:email] = user.email
		#cookies.permanent.signed[:phone_no] = user.phone_no
		cookies.permanent[:remember_token] = user.remember_token
	end

	#return true if the givenuser is current user
	def current_user?(user)
		user == current_user
	end

	#return the user corresponding to saved cookies
	def current_user
		if(u_id = session[:u_id])
			@current_user ||= User.find_by(u_id: u_id)
		elsif(u_id = cookies.signed[:u_id])
			user = User.find_by(u_id: u_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	#return true if an user is logged in
	def logged_in?
		!current_user.nil?
	end

	#forget user
	def forget(user)
		user.forget if !user.nil?
		cookies.delete(:u_id)
		#cookies.delete(:email)
		c#ookies.delete(:phone_no)
		cookies.delete(:remember_token)
	end

	#log out
	def log_out
		forget(current_user)
		session.delete(:u_id)
		#session.delete(:phone_no)
		#session.delete(:email)
		@current_user = nil
	end
end
