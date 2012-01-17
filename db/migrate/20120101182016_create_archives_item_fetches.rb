class CreateArchivesItemFetches < ActiveRecord::Migration
  def change
    create_table :archives_item_fetches do |t|
      t.string :uuid
      t.string :title
          
      t.string :refer_unique  #唯一的标识
      t.string :url_name 
      
      t.integer :created_by
      t.string :created_ip
      
      t.integer :content_way, :default => 0 #正文编码类型
      t.text :content
      
      t.text :virtue_encode  #属性编码后的yuml
      t.timestamps
    end
  end
end
