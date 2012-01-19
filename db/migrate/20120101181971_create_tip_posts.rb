class CreateTipPosts < ActiveRecord::Migration
  def change
    create_table :tip_posts do |t|
      t.string :uuid
      t.integer :context_flag
      
      t.string :title
      t.text :content
      t.string :lang, :default => LangConfig::DEFAULT_LANG
      t.integer :tip_comments_count, :default => 0
      
      t.integer :tip_category_id
      
      t.integer :created_by
      t.string :created_ip
      
      t.datetime :deleted_at
      
      t.integer :permission, :default => WebsiteConfig::PERMMISSION_PUBLIC
      t.text :permission_encode
      
      t.timestamps
    end
    
    add_index :tip_posts, [:uuid]
  end
end
