class BookDetail < ActiveRecord::Base
  belongs_to :item, :class_name => "BookItem", :foreign_key => "item_id"  
  has_and_belongs_to_many :book_category_fetches
  belongs_to :book_detail_fetch
  
end
