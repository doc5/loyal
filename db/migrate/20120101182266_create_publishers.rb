class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.integer :role_type #出版社？
      t.string :name
      t.text   :description      
      
      t.integer :book_items_count, :default => 0
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.timestamps
    end
    
    add_index :publishers, [:name, :role_type]
  end
end
