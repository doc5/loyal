class CreateOverallTaggings < ActiveRecord::Migration
  def change
    create_table :overall_taggings do |t|
      t.integer  "overall_tag_id"
      
      t.references :taggable, :polymorphic => true      
      t.string   "context"
      t.integer :position, :default => 0
      
      t.datetime "created_at"      
      t.timestamps
    end
    
    add_index "overall_taggings", ["overall_tag_id"], :name => "overall_taggings_tag_id"
    add_index "overall_taggings", ["taggable_id", "taggable_type", "context"], :name => "overall_taggable_index"
    
  end
end
