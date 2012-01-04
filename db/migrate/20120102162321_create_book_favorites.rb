class CreateBookFavorites < ActiveRecord::Migration
  def change
    create_table :book_favorites do |t|
      t.integer :item_id
      t.string :lang
      
      t.integer :created_by
      t.string :created_ip
      t.string :title
      
      t.text :description
      
      t.integer :position, :default => 0
      
      t.timestamps
    end
  end
end
