class CreateBookComments < ActiveRecord::Migration
  def change
    create_table :book_comments do |t|

      t.timestamps
    end
  end
end
