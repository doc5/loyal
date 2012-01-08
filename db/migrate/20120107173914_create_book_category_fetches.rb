class CreateBookCategoryFetches < ActiveRecord::Migration
  def change
    create_table :book_category_fetches do |t|
      t.string :url
      t.string :name
      t.integer :site_type
      t.integer :book_category_id
      
      t.integer :status
      
      # for tree 
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      
      t.integer :position, :default => 0
      
      t.timestamps
    end
    
    add_index :book_category_fetches, [:url]
    add_index :book_category_fetches, [:site_type]
  end
end
