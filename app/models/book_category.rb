class BookCategory < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree
  
  has_many :book_category_fetches
end
