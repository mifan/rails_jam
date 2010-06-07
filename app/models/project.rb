class Project < ActiveRecord::Base
  has_many :photos, :order => 'position'
  acts_as_taggable_on :tags

end
