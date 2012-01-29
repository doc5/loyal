class CreateArchivesTaggings < ActiveRecord::Migration
  def change
    create_table :archives_taggings do |t|
      t.integer  :tag_id
      
      t.references :taggable, :polymorphic => true      
      t.integer :position, :default => 0
      t.string   "context"
      
      t.datetime "created_at"
      t.timestamps
    end
    
    add_index :archives_taggings, ["tag_id"], :name => "archives_taggings_tag_id_index"
    add_index :archives_taggings, ["taggable_id", "taggable_type", "context"], :name => "archives_taggable_index"
  end
end