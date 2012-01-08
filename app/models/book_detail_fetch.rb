class BookDetailFetch < ActiveRecord::Base
  has_one :book_detail
  
  validates_uniqueness_of :url
  
  def fetch_detail
    book_detail ||= BookDetail.new(:book_detail_fetch_id => self.id)
  end
end
