class CreateBookTags < ActiveRecord::Migration
  def change
    create_table :book_tags do |t|
      t.string :name
      t.integer :book_items_count, :default => 0
      t.integer :users_count, :default => 0
      
      t.timestamps
    end
  end
end
