class BookCategory < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree
  
  has_and_belongs_to_many :fetch_book_category_links
  
  validates_presence_of :name, :url_name
  validates_uniqueness_of :url_name
end
