class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show, :about, :home]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @projects = Project.paginate(page: params[:page], per_page: 5)
  end

  def about

  end

  def home
    redirect_to projects_path if logged_in?
  end

  def new

    @project = Project.new
  end

  def edit

  end

  def create
    #render plain: params[:project].inspect (just to view)
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:success] = "Project has been successfully added."
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  def update

    if @project.update(project_params)
      flash[:success] = "Project updated."
      redirect_to project_path(@project)
    else
      render :edit
    end

  end

  def show
  end

  def destroy
    @project.destroy
    flash[:danger] = "Project deleted."
    redirect_to projects_path

  end

  private
   def set_project
     @project = Project.find(params[:id])
   end

   def project_params
     params.require(:project).permit(:title, :description, :project_link)
   end

   def require_same_user
    if current_user != @project.user
      flash[:danger] ="You cannot perform this action"
      redirect_to root_path
    end
  end

end
