class CreateBookBoxes < ActiveRecord::Migration
  def change
    create_table :book_boxes do |t|

      t.timestamps
    end
  end
end
