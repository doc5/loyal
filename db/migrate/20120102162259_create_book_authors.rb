class CreateBookAuthors < ActiveRecord::Migration
  def change
    create_table :book_authors do |t|
      t.integer :artist_id
      t.integer :book_detail_id
      
      t.integer :role_type  #原作家，翻译者
      t.integer :position, :default => 0
      
      t.integer :status, :default => 0
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
