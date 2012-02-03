class CreateSegHotWords < ActiveRecord::Migration
  def change
    create_table :seg_hot_words do |t|
      t.integer  :seg_word_id   
      t.references :seggable, :polymorphic => true
      
      t.integer :freq, :default => 0
      t.timestamps
    end
    
    add_index :seg_hot_words, ["seg_word_id"]
    add_index :seg_hot_words, ["seggable_id", "seggable_type"], :name => ":seg_hot_words_seggable_index"
  end  
end