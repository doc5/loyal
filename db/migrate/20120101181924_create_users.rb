# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account, :nil => false
      t.string :email
      t.string :nick_name
      
      t.string :password_hash
      t.string :password_salt
      
      t.boolean :sex
      t.date    :birthday
      t.boolean :birthday_lunar, :default => false  #是农历吗？
      
      t.integer :status
      t.string :created_ip      
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.timestamps
    end
    
    add_index :users, :account, :unique => true
    add_index :users, :email
  end
end
