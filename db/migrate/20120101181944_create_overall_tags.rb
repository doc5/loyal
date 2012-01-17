class CreateOverallTags < ActiveRecord::Migration
  def change
    create_table :overall_tags do |t|
      t.string "name"
    end
  end
end
