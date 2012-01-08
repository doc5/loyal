class BookDetail < ActiveRecord::Base
  belongs_to :item, :class_name => "BookItem", :foreign_key => "item_id"  
  has_and_belongs_to_many :book_category_fetches
  belongs_to :book_detail_fetch
  
  validates_presence_of :from_site, :from_uri
  validates_uniqueness_of :from_uri
  
end
