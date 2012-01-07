class ShipBookItemsAndBookCategories < ActiveRecord::Migration
  def change
    create_table :ship_book_items_and_book_categories, :id => false do |t|
      t.integer :item_id
      t.integer :category_id
    end
    
  end  
end
