module MongoModel
  class RssCatelog
    include MongoMapper::Document
    include ActsMethods::ActsAsHuabanerMongoMapper::Tree
    acts_as_huabaner_mongo_mapper_tree
    
    key :status_open, Boolean, :default => true     
    key :parent_id, ObjectId 
     
    key :url_name, String
    key :name, String
    key :name_short, String  #简称
    key :title, String
    key :created_by, Integer
    key :introduction, String
    key :description , String
      
    timestamps! # HECK YES
    
    many :rss_channels, :class_name => "MongoModel::RssChannel"
  end
end