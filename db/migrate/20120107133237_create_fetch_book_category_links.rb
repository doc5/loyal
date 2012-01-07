class CreateFetchBookCategoryLinks < ActiveRecord::Migration
  def change
    create_table :fetch_book_category_links do |t|
      t.string :url
      t.string :name
      t.integer :site_type
      
      # for tree 
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
    
    add_index :fetch_book_category_links, [:url]
    add_index :fetch_book_category_links, [:site_type]
  end
end
