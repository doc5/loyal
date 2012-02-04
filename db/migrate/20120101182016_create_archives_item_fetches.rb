class CreateArchivesItemFetches < ActiveRecord::Migration
  def change
    create_table :archives_item_fetches do |t|
      t.string :uuid
      t.string :title
      
      t.integer :from_site  #京东？当当？淘宝？亚马逊？豆瓣？？
      t.string :from_uri
      
      t.integer :created_by
      t.string :created_ip
      
      t.integer :content_way, :default => 0 #正文编码类型
      
      t.string :lang, :default => LangConfig::DEFAULT_LANG
      
      t.string :title
      t.text :content
      
      t.string :fetch_author
      t.datetime :fetch_pubtime      
      t.string :fetch_category, :default => ""
#      抓取
      t.string :fetch_tag_list, :default => ""      
#      可见？
      t.boolean :fetch_visible, :default => true
#      发表了
      t.boolean :fetch_published, :default => true
#      显示来源
      t.boolean :show_from, :default => false
#      计算出来的标签列表
      t.string :rec_tag_list, :default => ""
#      相关项目的列表
      t.string :related_item_ids_list, :default => ""
      
      t.string :virtue_way, :default => 'yaml'
      t.text :virtue_encode
      
      t.datetime :deleted_at
      
      t.timestamps
    end
    
    add_index :archives_item_fetches, [:uuid]
    add_index :archives_item_fetches, [:from_uri]
  end
end
