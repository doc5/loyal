class CreateBookItems < ActiveRecord::Migration
  def change
    create_table :book_items do |t|
      t.string :uuid
      
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
      
      t.integer :book_origins_count, :default => 0
      
      t.integer :book_interests_doing_count,   :default => 0
      t.integer :book_interests_wish_count,    :default => 0
      t.integer :book_interests_collect_count, :default => 0      
      
      t.integer :total_score, :default => 0
      t.integer :scores_count, :default => 0
      t.integer :scores_a_count, :default => 0 #1星
      t.integer :scores_b_count, :default => 0 #2星
      t.integer :scores_c_count, :default => 0 #3星
      t.integer :scores_d_count, :default => 0 #4星
      t.integer :scores_e_count, :default => 0 #5星
      
      t.integer :pages_count, :default => 0
      
      t.integer :binding  #包装类型
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.timestamps
    end
    
    add_index :book_items, [:uuid]
    add_index :book_items, [:isbn]
    add_index :book_items, [:isbn_other]    
  end
end
