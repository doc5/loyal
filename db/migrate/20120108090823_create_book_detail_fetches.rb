class CreateBookDetailFetches < ActiveRecord::Migration
  def change
    create_table :book_detail_fetches do |t|
      t.string :url
      t.string :title
      t.integer :from_site
      
      t.timestamps
    end
    
    add_index :book_detail_fetches, [:url]
  end
end
