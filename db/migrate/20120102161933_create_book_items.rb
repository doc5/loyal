class CreateBookItems < ActiveRecord::Migration
  def change
    create_table :book_items do |t|
      t.string :isbn
      t.string :isbn_other
      
      t.integer :series_id #系列id
      
      t.string :published_by
      t.date   :published_at
      t.string :price
      
      t.integer :book_comments_count,  :default => 0
      t.integer :book_notes_count    , :default => 0
      t.integer :book_interests_count, :default => 0
      t.integer :book_scores_count,    :default => 0
      t.integer :book_favorites_count, :default => 0
      
      t.integer :book_interests_doing_count,   :default => 0
      t.integer :book_interests_wish_count,    :default => 0
      t.integer :book_interests_collect_count, :default => 0      
      
      t.integer :average_score, :default => 0
      t.integer :pages_count, :default => 0
      
      t.integer :binding  #包装类型
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.string :fetch_tushucheng_id
      t.string :fetch_dangdang_id
      t.string :fetch_douban_id
      t.string :fetch_amazon_cn_id
      t.string :fetch_360buy_id
      t.string :fetch_baidu_wiki_id
      
      t.timestamps
    end
    
    add_index :book_items, [:isbn]
    add_index :book_items, [:isbn_other]    
  end
end
