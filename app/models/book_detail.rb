class BookDetail < ActiveRecord::Base
  belongs_to :item, :class_name => "BookItem", :foreign_key => "item_id"
end
