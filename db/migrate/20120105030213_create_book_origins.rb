class CreateBookOrigins < ActiveRecord::Migration
  def change
    create_table :book_origins do |t|

      t.timestamps
    end
  end
end
