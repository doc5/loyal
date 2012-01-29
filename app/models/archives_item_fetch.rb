class ArchivesItemFetch < ActiveRecord::Base
  validates_uniqueness_of :unique_url, :message =>"已经被占用了"
  
  has_many :avatars, :class_name => "ArchivesAvatar", :as => :resource
  has_one :first_avatar, :class_name => "ArchivesAvatar", :as => :resource, 
    :order => "position ASC"
end
