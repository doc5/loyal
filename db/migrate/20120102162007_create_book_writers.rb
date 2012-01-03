class CreateBookWriters < ActiveRecord::Migration
  def change
    create_table :book_writers do |t|
      t.string :uuid
      t.string :name
      t.text   :description
      
      t.integer :book_items_count, :default => 0
      
      t.string :uri_baidu_baike
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.timestamps
    end
  end
end
