class CreateArchivesItemFetches < ActiveRecord::Migration
  def change
    create_table :archives_item_fetches do |t|
      t.string :uuid
      t.string :title
      
      t.string :unique_url
      
      t.integer :created_by
      t.string :created_ip
      
      t.integer :content_way, :default => 0 #正文编码类型
      t.text :content
      
      t.text :virtue_encode  #属性编码后的yuml
      
      t.datetime :deleted_at
      
      t.timestamps
    end
    
    add_index :archives_item_fetches, [:uuid]
    add_index :archives_item_fetches, [:unique_url]
  end
end
