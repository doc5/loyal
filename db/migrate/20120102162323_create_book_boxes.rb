class CreateBookBoxes < ActiveRecord::Migration
  def change
    create_table :book_boxes do |t|
      t.integer :created_by
      t.string :created_ip
      
      t.string :title
      t.text   :description
      
      t.integer :book_items_count, :default => 0
      t.integer :book_comments_count, :default => 0
      
      t.integer :status, :default => 0
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
