class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.boolean   :cover, :null => false, :default => false

      t.string    :attachment_file_name
      t.string    :attachment_content_type
      t.integer   :attachment_file_size
      t.datetime  :attachment_updated_at
      #acts as list
      t.integer   :position

      t.references :project
    end

  end

  def self.down
    drop_table :photos
  end
end
