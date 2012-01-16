class CreateOverallCategories < ActiveRecord::Migration
  def change
    create_table :overall_categories do |t|

      t.timestamps
    end
  end
end
