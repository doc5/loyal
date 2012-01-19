class CreateBookFetchUrls < ActiveRecord::Migration
  def change
    create_table :book_fetch_urls do |t|
      t.string :resource_type
      t.string :resource_id
      
      t.integer :from_site
      
      t.string :url
      
      t.integer :status, :default => 0
      t.datetime :deleted_at
      t.timestamps
    end
    
    add_index :book_fetch_urls, [:resource_id, :resource_type, :from_site], :name => "book_fetch_urls_res_index"
  end
end
