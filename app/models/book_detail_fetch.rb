class BookDetailFetch < ActiveRecord::Base
  has_one :book_detail
  
  validates_uniqueness_of :url
  
  def fetch_detail
    
  end
end
