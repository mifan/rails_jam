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

  def edit
    @project = Project.find(params[:id])
    @page_title = "Edit project" 
  end


  def git
    require 'open-uri'
    git_project_link = params[:git_project_link]
    if git_project_link.start_with?("http://github.com/")
      user_project = git_project_link.gsub(/http:\/\/github.com\//,'')
      if  user_project =~ /\w+\/\w+/
        user_project_repos_path = "http://github.com/api/v2/json/repos/show/" + user_project
	begin
          json_response = open(user_project_repos_path).read
        rescue
	  json_response = '{"repository":"error"}'
	end
      end
    end
    json_response = '{"repository":"error"}' unless defined?(json_response)
    render :text => json_response
  end


end
