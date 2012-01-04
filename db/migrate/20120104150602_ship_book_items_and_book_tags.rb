class ShipBookItemsAndBookTags < ActiveRecord::Migration
  def change
    create_table :ship_book_items_and_book_tags, :id => false do |t|
      t.integer :item_id
      t.integer :tag_id
    end
    
    add_index :ship_book_items_and_book_tags, [:item_id, :tag_id], :name => "ship_book_items_and_book_tags_index"
  end 
end
