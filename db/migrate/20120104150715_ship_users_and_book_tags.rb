class ShipUsersAndBookTags < ActiveRecord::Migration
  def change
    create_table :ship_users_and_book_tags, :id => false do |t|
      t.integer :user_id
      t.integer :tag_id
    end
    
    add_index :ship_users_and_book_tags, [:user_id, :tag_id], :name => "ship_users_and_book_tags_index"
  end 
end
