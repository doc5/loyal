class ShipBookCategoriesAndFetchBookCategoryLinks < ActiveRecord::Migration
  def up
    create_table :book_categories_fetch_book_category_links, :id => false do |t|
      t.integer :book_category_id
      t.integer :fetch_book_category_link_id
      t.timestamps
    end
  end

  def down
    drop_table :book_categories_fetch_book_category_links
  end
end
