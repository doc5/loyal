class CreateUserRemembers < ActiveRecord::Migration
  def change
    create_table :user_remembers do |t|
      t.integer :user_id
      t.string :token
      t.string :expired_at
      t.string :created_ip
      
      t.timestamps
    end
    
    add_index :user_remembers, [:user_id, :token], :name => "user_remembers_token"
  end
end
