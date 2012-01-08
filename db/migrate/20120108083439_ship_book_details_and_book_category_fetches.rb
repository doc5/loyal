class ShipBookDetailsAndBookCategoryFetches < ActiveRecord::Migration
  def change
    create_table :book_category_fetches_book_details, :id => false do |t|
      t.integer :book_detail_id
      t.integer :book_category_fetch_id
    end    
  end  
end
