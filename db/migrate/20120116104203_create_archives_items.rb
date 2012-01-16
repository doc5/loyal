class CreateArchivesItems < ActiveRecord::Migration
  def change
    create_table :archives_items do |t|

      t.timestamps
    end
  end
end
