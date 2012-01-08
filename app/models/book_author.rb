class BookAuthor < ActiveRecord::Base
  has_many :book_items
end
