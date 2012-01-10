class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.integer :role_type #出版社？
      t.string :name
      t.text   :description      
      
      t.integer :book_items_count, :default => 0
      t.integer :book_details_count, :default => 0
      
      t.integer :overall_avatars_count, :default => 0
      
      t.timestamps
    end
    
    add_index :publishers, [:name, :role_type]
  end
end
