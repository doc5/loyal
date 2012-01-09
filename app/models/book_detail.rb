class BookDetail < ActiveRecord::Base
  belongs_to :item, :class_name => "BookItem", :foreign_key => "item_id", :counter_cache => true  
  has_and_belongs_to_many :book_category_fetches
  has_one :book_detail_fetch, :foreign_key => :url, :primary_key => :from_uri
  belongs_to :publisher, :counter_cache => true
  
  validates_presence_of :from_site, :from_uri
  validates_uniqueness_of :from_uri
  
  def fetch
    unless book_detail_fetch.nil?
      book_detail_fetch.fetch_detail
    end
  end
end
