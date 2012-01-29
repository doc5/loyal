class ShipArchivesItemsAndArchivesCategories < ActiveRecord::Migration
  def up
    create_table :archives_items_and_archives_categories, :id => false do |t|
      t.integer :archives_item_id
      t.integer :archives_category_id
      t.integer :ship_flag, :default => 0
    end  
  end

  def down
    drop_table :archives_items_and_archives_categories
  end
end
