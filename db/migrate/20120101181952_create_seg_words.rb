class CreateSegWords < ActiveRecord::Migration
  def change
    create_table :seg_words do |t|
      t.integer :name
    end
  end
end
