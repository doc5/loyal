class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :uuid
      t.integer :role_type #出版社？
      t.string :name
      t.text   :description      
      
      t.integer :book_items_count, :default => 0
      
      t.string :fetch_baidu_wiki_id
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.timestamps
    end
    
    add_index :publishers, [:name]
  end
end
