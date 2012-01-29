class CreateArchivesItems < ActiveRecord::Migration
  def change
    create_table :archives_items do |t|
      t.string :uuid
      t.string :title
          
      t.string :unique_refer  #唯一的标识
      
      t.integer :created_by
      t.string :created_ip
      
      t.integer :content_way, :default => 0 #正文编码类型
      t.text :content
      
      t.text :virtue_encode  #属性编码后的yuml
      
      t.datetime :deleted_at
      t.timestamps
    end
    
    add_index :archives_items, [:uuid]
    add_index :archives_items, [:unique_refer]
  end
end
