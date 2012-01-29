class ShipArchivesItemsAndArchivesCategories < ActiveRecord::Migration
  def up
    create_table :archives_items_and_archives_categories, :id => false do |t|
      t.integer :item_id
      t.integer :category_id
    end  
  end

  def down
    drop_table :archives_items_and_archives_categories
  end
end
