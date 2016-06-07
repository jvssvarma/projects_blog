class SessionsController < ApplicationController

	def new 

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			if user.email_confirmed
				session[:user_id] = user.id
				flash[:success] = "Logged in Successful!"
				redirect_to user_path(user)
			else
				flash[:error] = "Please confirm your email address to activate your account. Follow instructions in your confirmation email."
				render 'new'
			end
		else
			flash.now[:danger] = "Incorrect Login Information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Logged out Successful"
		redirect_to root_path
	end



end