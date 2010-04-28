class PhotosController < ApplicationController
  def create
    @image = Image.new params[:image]
    if @image.save
      respond_to do |format|
        format.json { render :json => generate_success.to_json }
      end
    else
      respond_to do |format|
        format.json { render :json => generate_failure.to_json, :status => :unprocessable_entity }
      end
    end
  end
  
  def new
    @image = Image.new(params[:image])
    @images = Image.all
  end
  
  def destroy
    @images = Image.find(params[:id])
    @images.destroy
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
    render_to_string :template => 'images/_image.html.erb', :layout => false, :locals => {:image => @image}
  end
end
