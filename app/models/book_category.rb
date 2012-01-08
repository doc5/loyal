class BookCategory < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree
  
  has_many :book_category_fetches
  
  validates_presence_of :from_site
  validates_uniqueness_of :from_uri
end
