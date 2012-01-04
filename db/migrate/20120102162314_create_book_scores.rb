class CreateBookScores < ActiveRecord::Migration
  def change
    create_table :book_scores do |t|
      t.string  :resource_type
      t.integer :resource_id
      
      t.integer :created_by
      t.string  :created_ip
      
      t.integer :point      
      
      t.timestamps
    end
  end
end
