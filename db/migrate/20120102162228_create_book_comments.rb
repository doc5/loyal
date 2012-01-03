class CreateBookComments < ActiveRecord::Migration
  def change
    create_table :book_comments do |t|
      t.integer :item_id
      t.integer :score_id
      
      t.string  :lang
      t.string  :title
      t.text    :content
      
      t.integer :created_by
      t.string  :created_ip
      
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
