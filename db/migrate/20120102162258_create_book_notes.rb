class CreateBookNotes < ActiveRecord::Migration
  def change
    create_table :book_notes do |t|
      t.integer :item_id
      t.integer :score_id
      
      t.string  :lang
      t.string  :title
      t.integer :chapter_page
      t.integer :chapter_title
      t.text    :content
      
      t.integer :created_by
      t.string  :created_ip
      
      t.integer :permission_type
      t.text    :permission_text
      
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
