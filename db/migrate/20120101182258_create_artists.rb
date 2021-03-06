class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :uuid
      
      t.string :name
      t.text   :description  
#      t.integer :poly_type, :default => 0  
#      
#      t.integer :book_items_count, :default => 0
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.datetime :deleted_at
      t.timestamps
    end
    
    add_index :artists, [:uuid]    
    add_index :artists, [:name]
  end
end
