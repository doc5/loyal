class CreateBookDetails < ActiveRecord::Migration
  def change
    create_table :book_details do |t|
      t.integer :item_id
      t.string :lang, :default => LangConfig::DEFAULT_LANG
      
      t.integer :book_detail_fetch_id
      
      t.integer :from_site  #京东？当当？淘宝？亚马逊？豆瓣？？
      t.string :from_uri
      t.integer :position, :default => 0
      
      t.integer :publisher_id
      
      t.string :isbn      
      t.string :title #标题
      t.string :subtitle #副标题
      t.string :original_title #原始标题  
      t.string :cn_title #中文书名
      t.integer :revision #版次
      t.string :price #定价
      t.string :price_shop #店铺的价格
      t.string :production_number #商品编号
      t.string :paper_type #纸张类型
      t.integer :paper_count, :default => 0
      t.integer :print_count, :default => 0 #印刷次数
      t.string :lang_tag #语种    
      t.string :format_tag #装帧
      t.date   :published_at #出版日期
      
      t.string :published_by
      
      t.text :content_outline #内容提要
      t.text :content_author  #作者简介
      t.text :content_editor  #编辑推荐
      t.text :content_catelog #目录
      t.text :content_note    #书摘      
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.timestamps
    end
    
    add_index :book_details, [:item_id, :lang, :from_site, :from_uri], :name => "book_details_item_lang_index"
    add_index :book_details, [:item_id, :lang, :from_site, :from_uri, :position], :name => "book_details_item_pos_index"
  end
end
