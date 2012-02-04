class CreateArchivesItems < ActiveRecord::Migration
  def change
    create_table :archives_items do |t|
      t.string :uuid
      t.string :title
      
      t.string :unique_flag, :default => "URL"   #唯一标识的类型
      t.string :unique_refer  #唯一的标识  
      
      t.string :rec_author
#      计算出来的标签列表
      t.string :rec_tag_list, :default => ""
#      可见？
      t.boolean :rec_visible, :default => true
#      发表了
      t.boolean :rec_published, :default => true
#      显示来源
      t.boolean :show_refer, :default => false
#      相关项目的列表
      t.string :related_item_ids_list, :default => ""
      
      t.integer :created_by
      t.string :created_ip
      
      t.integer :content_way, :default => 0 #正文编码类型
      t.text :content
      
      t.string :virtue_way, :default => 'yaml'
      t.text :virtue_encode
      
      t.datetime :deleted_at
      
      t.timestamps
    end
    
    add_index :archives_items, [:uuid]
    add_index :archives_items, [:unique_flag, :unique_refer], :name => "archives_items_unique_index"
  end
end
