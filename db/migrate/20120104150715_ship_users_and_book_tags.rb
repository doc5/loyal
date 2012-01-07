class ShipUsersAndBookTags < ActiveRecord::Migration
  def change
    create_table :ship_users_and_book_tags, :id => false do |t|
      t.integer :user_id
      t.integer :tag_id
    end
  end 
end
