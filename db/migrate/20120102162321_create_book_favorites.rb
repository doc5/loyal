class CreateBookFavorites < ActiveRecord::Migration
  def change
    create_table :book_favorites do |t|

      t.timestamps
    end
  end
end
