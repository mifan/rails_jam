class PhotosController < ApplicationController
  def index
    @project = Project.find params[:project_id]
    @photos = @project.photos
    render :layout => 'photo_upload'
  end  
  
  def create
    @project = Project.find params[:project_id]
    #@photo = Photo.new params[:image]
    @photo = @project.photos.build(params[:image])
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

  def sort
  project = Project.find params[:project_id]
  photos = project.photos
  changed_photos = []
  photos.each do |photo|
    photo_position = params['photos'].index(photo.id.to_s) + 1
      if(photo.position != photo_position)
        photo.position = photo_position
	photo.save
        changed_photos << photo.id
      end
      
    end
    render :json => { :changed_photos => changed_photos}.to_json
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
    render_to_string :template => 'photos/_photo.html.erb', :layout => false, :locals => {:photo => @photo}
    #render @photo
  end
end
