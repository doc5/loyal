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
      
      t.string :virtue_way, :default => 'yaml'
      t.text :virtue_encode
      
      t.datetime :deleted_at
      
      t.timestamps
    end
    
    add_index :archives_item_fetches, [:uuid]
    add_index :archives_item_fetches, [:from_uri]
  end
end
