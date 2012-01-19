class CreateTipComments < ActiveRecord::Migration
  def change
    create_table :tip_comments do |t|
      t.string :uuid
      t.integer :post_id
      t.string :content
      
      t.integer :created_by
      t.string :created_ip
      
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :tip_comments, [:uuid]
  end
end
