class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string     :name, :limit => 80, :null => false
      t.text       :description

      t.string     :home_page
      t.string     :source_link
      t.string     :demo_link


      t.references :user
      
      t.timestamp  :code_changed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
