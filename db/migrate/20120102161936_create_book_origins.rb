class CreateBookOrigins < ActiveRecord::Migration
  def change
    create_table :book_origins do |t|   
      t.integer :item_id
      t.string :from_type
      t.string :from_uri
      
#      t.string :fetch_tushucheng_id
#      t.string :fetch_dangdang_id
#      t.string :fetch_douban_id
#      t.string :fetch_amazon_cn_id
#      t.string :fetch_360buy_id
#      t.string :fetch_baidu_wiki_id
      t.timestamps
    end
    
    add_index :book_origins, [:item_id, :from_type, :from_uri], :name => "book_origins_from_index"
  end
end
