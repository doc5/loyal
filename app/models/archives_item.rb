class ArchivesItem < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::UuidExtends
  acts_as_huabaner_uuid
  
  include ActsMethods::ActsAsHuabanerModel::VirtueEncodeNode
  acts_as_huabaner_virtue_encode_node
  
  
  has_and_belongs_to_many :categories, :join_table => "archives_items_and_archives_categories",
    :class_name => "ArchivesCategory", :foreign_key => "item_id",
    :association_foreign_key => "category_id"
  
  
#  for search attrs
  def shared_searcher_categories
    
  end
  
  def shared_searcher_created_by
    
  end
  
  def shared_searcher_title
    self.title
  end
  
  def shared_searcher_content
    March::StringTools.clean_html(self.content)
  end
  
  def shared_searcher_created_at
    self.created_at.to_s
  end
  def shared_searcher_updated_at
    self.updated_at.to_s
  end  
end
