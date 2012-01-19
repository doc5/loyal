class CreateBookScores < ActiveRecord::Migration
  def change
    create_table :book_scores do |t|
      t.string  :resource_type
      t.integer :resource_id
      
      t.integer :created_by
      t.string  :created_ip
      
      t.integer :point      
      
      t.integer :status, :default => 0
      t.datetime :deleted_at
      t.timestamps
    end
    
    add_index :book_scores, [:resource_type, :resource_id], :name => 'book_scores_res_index'
  end
end
