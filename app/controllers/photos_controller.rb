class PhotosController < ApplicationController
  def index
    render :layout => 'photo_upload' 
  end  
  
  def create
    @project = Project.find params[:project_id]
    @photo = Photo.new params[:image]
    if @photo.save
      #respond_to do |format|
      #  format.json { render :json => generate_success.to_json }
      #end
      render :json => generate_success.to_json
    else
      #respond_to do |format|
      #  format.json { render :json => generate_failure.to_json, :status => :unprocessable_entity }
      #end
      render :json => generate_failure.to_json, :status => :unprocessable_entity
    end
  end
  
  def new
    @photo = Photo.new(params[:image])
    @photos = Photo.all
  end
  
  def destroy
    @photos = Photo.find(params[:id])
    @photos.destroy
    redirect_to :action => :new
  end
  
  private
  def generate_success
    {
      :success => true,
      :partial => generate_partial
    }
  end
  
  def generate_failure
    {
      :success => false
    }
  end
  
  
  def generate_partial
    render_to_string :template => 'photos/_photo.html.erb', :layout => false, :locals => {:photo => @photo ,:project => @project}
  end
end
