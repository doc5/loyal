class CreateBookScores < ActiveRecord::Migration
  def change
    create_table :book_scores do |t|

      t.timestamps
    end
  end
end
