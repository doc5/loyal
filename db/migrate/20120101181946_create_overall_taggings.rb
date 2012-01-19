class CreateOverallTaggings < ActiveRecord::Migration
  def change
    create_table :overall_taggings do |t|
      t.integer  "tag_id"
      
      t.integer :status, :default => 0
      
      t.references :taggable, :polymorphic => true      
      t.integer :position, :default => 0
      t.string   "context"
      
      t.datetime "created_at"      
      t.timestamps
    end
    
    add_index "overall_taggings", ["tag_id"], :name => "tag_id"
    add_index "overall_taggings", ["taggable_id", "taggable_type", "context"], :name => "overall_taggable_index"
    
  end
end
