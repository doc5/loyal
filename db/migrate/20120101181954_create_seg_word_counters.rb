class CreateSegWordCounters < ActiveRecord::Migration
  def change
    create_table :seg_word_counters do |t|
      t.integer  :seg_word_id
      t.string :seggable_type
      t.integer :count, :default => 0
      t.integer :entity_count, :default => 0
      t.timestamps
    end
  end
end
