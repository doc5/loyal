class CreateBookNotes < ActiveRecord::Migration
  def change
    create_table :book_notes do |t|

      t.timestamps
    end
  end
end
