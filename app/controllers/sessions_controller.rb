class SessionsController < ApplicationController

	def new 

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "Logged in Successful!"
			redirect_to user_path(user)
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