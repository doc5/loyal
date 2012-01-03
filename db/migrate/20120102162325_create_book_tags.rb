class CreateBookTags < ActiveRecord::Migration
  def change
    create_table :book_tags do |t|

      t.timestamps
    end
  end
end
