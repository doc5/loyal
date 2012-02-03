class ArchivesCategory < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree  
  validates_presence_of :url_name, :flag_name
  validates_uniqueness_of :url_name
  validates_uniqueness_of :flag_name
  
  class << self
    def touch(options={})
      cate = ArchivesCategory.find_by_flag_name(options[:flag_name])
      if cate.nil?
        cate = ArchivesCategory.new options
      end
      cate.save
      cate
    end
  end
  
end
