class ShipBookItemsAndBookCategories < ActiveRecord::Migration
  def change
    create_table :ship_book_items_and_book_categories, :id => false do |t|
      t.integer :item_id
      t.integer :category_id
    end
    
    add_index :ship_book_items_and_book_categories, [:item_id, :category_id], :name => "book_item_category_ship_index"
  end  
end
