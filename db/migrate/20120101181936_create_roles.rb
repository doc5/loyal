# -*- encoding : utf-8 -*-
class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :unique => true
      
      t.string :remark
      t.text :description
      t.boolean :available

      t.timestamps
    end
    add_index :roles, :name
  end
end
