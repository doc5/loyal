class CreateBookDetailAvatars < ActiveRecord::Migration
  def change
    create_table :book_detail_avatars do |t|
      t.string :from_uri
      
      t.string :resource_type
      t.integer :resource_id
      t.integer :position, :default => 0
      
      t.string :title
      t.string :alt
      t.string :name
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.integer :status, :default => 0
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
