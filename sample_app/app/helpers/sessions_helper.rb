module SessionsHelper
	def log_in(user)
	  session[:user_id] = user.id 
	end

	# Remembers a user in a persistent session.
	def remember(user)
	  user.remember
	  cookies.permanent.signed[:user_id] = user.id
	  cookies.permanent[:remember_token] = user.remember_token
	end

	def current_user
		if session[:user_id]
			if @current_user.nil?
				@current_user = User.find_by(id: session[:user_id])
			else
				@current_user
			end
		elsif cookies.signed[:user_id]
			user = User.find_by(id: cookies.signed[:user_id])
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
			
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user?(user)
	  user == current_user
	end
end
