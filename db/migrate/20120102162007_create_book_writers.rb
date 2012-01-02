class CreateBookWriters < ActiveRecord::Migration
  def change
    create_table :book_writers do |t|

      t.timestamps
    end
  end
end
