class ProjectsController < ApplicationController
  def index
    @projects = Project.order('id DESC')
  end

  def new
    @project = Project.new
    @page_title = "New paste " 
  end

  def create
    @project = Project.new(params[:project])
    @project.save!
    redirect_to(@project)
  end

   def show
    @project = Project.find(params[:id])
  end

end
