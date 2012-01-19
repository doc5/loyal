class CreateTipTaggings < ActiveRecord::Migration
  def change
    create_table :tip_taggings do |t|
      t.integer  "tag_id"
      
      t.references :taggable, :polymorphic => true      
      t.integer :position, :default => 0
      t.string   "context"
      
      t.datetime "created_at"      
      t.timestamps
    end
    
    add_index :tip_taggings, ["tag_id"], :name => "tip_taggings_tag_id"
    add_index :tip_taggings, ["taggable_id", "taggable_type", "context"], :name => "tip_taggable_index"
  end
end
