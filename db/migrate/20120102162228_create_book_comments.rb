class CreateBookComments < ActiveRecord::Migration
  def change
    create_table :book_comments do |t|
      t.string  :resource_type
      t.integer :resource_id
      
      t.integer :score_id
      
      t.string  :lang
      t.string  :title
      t.text    :content
      
      t.integer :created_by
      t.string  :created_ip
      
      t.datetime :deleted_at

      t.timestamps
    end
    
    add_index :book_comments, [:resource_type, :resource_id], :name => "book_comments_resource_index"
  end
end
