class CreateBookFetchUrls < ActiveRecord::Migration
  def change
    create_table :book_fetch_urls do |t|
      t.string :resource_type
      t.string :resource_id
      
      t.integer :site_type
      
      t.string :url
      
      t.timestamps
    end
    
    add_index :book_fetch_urls, [:resource_id, :resource_type, :site_type], :name => "book_fetch_urls_res_index"
  end
end
