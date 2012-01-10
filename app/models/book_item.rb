class BookItem < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::UuidExtends
  acts_as_huabaner_uuid
  
  has_many :book_details, :foreign_key => "item_id"
  has_one :first_detail, :class_name => "BookDetail", :conditions => "position=0", :foreign_key => "item_id"
  
  def name_display
    "#{first_detail.title}[#{self.isbn}]"
  end
  
  class << self
    
  end
end
