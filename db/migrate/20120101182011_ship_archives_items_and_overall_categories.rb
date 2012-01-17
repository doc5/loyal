class ShipArchivesItemsAndOverallCategories < ActiveRecord::Migration
  def up
    create_table :archives_items_and_overall_categories, :id => false do |t|
      t.integer :archives_item_id
      t.integer :overall_category_id
    end  
  end

  def down
    drop_table :archives_items_and_overall_categories
  end
end
