class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :email,               :null => false                
      t.string    :crypted_password,    :null => false                
      t.string    :password_salt,       :null => false                

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 
      t.integer   :failed_login_count,  :null => false, :default => 0 
      t.datetime  :last_request_at                                  
      t.datetime  :current_login_at                                  
      t.datetime  :last_login_at               
      t.string    :current_login_ip                           
      t.string    :last_login_ip    
      
      t.string :created_ip   
      
      t.string :nick_name
      
      t.boolean :sex
      t.date    :birthday
      t.boolean :birthday_lunar, :default => false  #是农历吗？
      
      t.integer :status   
      
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.datetime :deleted_at
      
      t.timestamps
    end
    add_index :users, [:email, :deleted_at], :name => "users_email_deleted_at"
  end
end
