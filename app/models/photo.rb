class Photo < ActiveRecord::Base
  belongs_to :project
  acts_as_list :scope => :project

  #has_attached_file :attachment, :styles => {:thumb => ["64x64#", :jpg]},
  #                          :url    => ":base_url/:resource/:styles_folder:basename:style_filename.:extension",
  #                         :path   => "public/u/:resource/:styles_folder:basename:style_filename.:extension" 
  has_attached_file :attachment, :styles => { :thumb => ["64x64#", :png] , :slide => ["600x450", :jpg] }

  #attr_accessor :tmp_upload_dir
  #after_create  :clean_tmp_upload_dir
  
  # handle new param
  def fast_asset=(file)
    if file && file.respond_to?('[]')
      self.tmp_upload_dir = "#{file['filepath']}_1"
      tmp_file_path = "#{self.tmp_upload_dir}/#{file['original_name']}"
      FileUtils.mkdir_p(self.tmp_upload_dir)
      FileUtils.mv(file['filepath'], tmp_file_path)
      self.asset = File.new(tmp_file_path)
    end
  end    
  
  private
  # clean tmp directory used in handling new param
  def clean_tmp_upload_dir
    FileUtils.rm_r(tmp_upload_dir) if self.tmp_upload_dir && File.directory?(self.tmp_upload_dir)
  end                     

end
