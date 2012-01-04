class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|

      t.timestamps
    end
  end
end
