class CreateTipCategories < ActiveRecord::Migration
  def change
    create_table :tip_categories do |t|
      t.string :name
      t.string :title
      
      t.string :url_name
      t.integer :position, :default => 0
      t.string :flag_name
      
      t.string :lang, :default => LangConfig::DEFAULT_LANG
      
      t.string :introduction
      t.text :description
      
      t.integer :permission, :default => WebsiteConfig::PERMMISSION_PUBLIC
      t.text :permission_encode
      
      t.integer :created_by
      t.string :created_ip
      
      t.integer :style_config_id
      t.text :style_config_text
      
      # for tree 
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.timestamps
    end
  end
end
