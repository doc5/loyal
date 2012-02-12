class ModifyColumns < ActiveRecord::Migration
  def up
    #    add_column :archives_item_fetches, :related_item_ids_list, :string
    #    add_column :archives_items, :related_item_ids_list, :string
    change_table :archives_item_fetches do |t|
      t.change :fetch_pubtime, :string
    end
    
    add_column :archives_item_fetches, :fetch_images, :text
  end

  def down
  end
end
