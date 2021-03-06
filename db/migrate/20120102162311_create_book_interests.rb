class CreateBookInterests < ActiveRecord::Migration
  def change
    create_table :book_interests do |t|      
      t.integer :item_id
      t.integer :score_id
      
      t.integer :status_type #读过？在读？想读？
      t.text    :content
      
      t.integer :permission_type
      t.text    :permission_encode
      
      t.integer :status, :default => 0
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
