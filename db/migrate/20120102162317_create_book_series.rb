class CreateBookSeries < ActiveRecord::Migration
  def change
    create_table :book_series do |t|
      t.string :name
      t.string :name_en
      
      t.integer :book_items_count, :default => 0
      t.string :title
      t.text   :description
      
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
