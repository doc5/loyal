class CreateBookItems < ActiveRecord::Migration
  def change
    create_table :book_items do |t|

      t.timestamps
    end
  end
end
