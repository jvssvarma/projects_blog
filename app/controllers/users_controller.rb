class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:user_id] = @user.id
      flash[:success] = "Please confirm your email address #{@user.username} to continue"
      redirect_to user_path(@user)
    else
      flash[:error] = "Ooopss! Something went wrong!"
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @user.update(user_params)
      flash[:success] = "Profile Rejuvenate Successful :-)"
      redirect_to projects_path
    else
      render 'edit'
    end
  end
  
  def show
    
    @user_projects = @user.projects.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "#{@user.username}'s profile and projects are deleted."
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :full_name, :email, :password, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You are forbidden to perform this action"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "You are not worthy to perform this action"
      redirect_to root_path
    end
  end
end