class CreateBookDetails < ActiveRecord::Migration
  def change
    create_table :book_details do |t|
      t.integer :item_id
      t.string :lang, :default => LangConfig::DEFAULT_LANG
      
      t.string :title
      t.string :subtitle
      t.string :original_title
      
      
      t.string :published_by
      t.date   :published_at
      t.string :price
      
      t.text :content_outline #内容提要
      t.text :content_author  #作者简介
      t.text :content_editor  #编辑推荐
      t.text :content_catelog #目录
      t.text :content_note    #书摘
      t.timestamps
    end
    
    add_index :book_details, [:item_id, :lang], :name => "book_details_item_lang_index"
  end
end
