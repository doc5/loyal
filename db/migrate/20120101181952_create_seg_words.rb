class CreateSegWords < ActiveRecord::Migration
  def change
    create_table :seg_words do |t|
      t.string :name
      t.integer :status, :default => 0
      t.integer :freq, :default => 0
            
#      是否屏蔽？
      t.boolean :blocked, :default => false
#      是否分词？
      t.boolean :seggable, :default => true
    end
    
    add_index :seg_words, [:name]
#    add_index :seg_words, [:name, :seggable]
#    add_index :seg_words, [:name, :blocked]
#    add_index :seg_words, [:name, :seggable, :blocked]
  end
end
