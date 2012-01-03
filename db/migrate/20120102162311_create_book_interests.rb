class CreateBookInterests < ActiveRecord::Migration
  def change
    create_table :book_interests do |t|

      t.timestamps
    end
  end
end
