class ProjectsController < ApplicationController

  def index
    @projects = Project.order('id DESC')
    @tags = Project.tag_counts_on(:tags)
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
    @commits = new_commits(@project)
  end

  def edit
    @project = Project.find(params[:id])
    @page_title = "Edit project" 
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes!(params[:project])
    redirect_to(@project)
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

 

  private 
  def git_user_project(project)
    git_project_link = project.source_link
    if git_project_link.start_with?("http://github.com/")
      user_project = git_project_link.gsub(/http:\/\/github.com\//,'')
      return user_project  if  user_project =~ /\w+\/\w+/
    end
    nil
  end

  #[hash...]
  def new_commits(project)
    require 'open-uri'
    require 'json'
    require 'digest/md5'
    new_commits = []
    temp_user_project = git_user_project(project)
    return new_commits if temp_user_project == nil

    user_project_commits_path = "http://github.com/api/v2/json/commits/list/#{temp_user_project}/master"
    begin
      json_response = open(user_project_commits_path).read
      result = JSON.parse(json_response)
      commits = result['commits']
      commits.each_with_index do |commit,index|
        new_commits << commit
        break if index > 8
      end
    rescue
    end
    new_commits
  end
 

end
