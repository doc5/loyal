class ArchivesCategory < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree  
  validates_uniqueness_of :url_name
  validates_uniqueness_of :flag_name
  
end
