class ShipTipCategoriesAndTipPosts < ActiveRecord::Migration
  def up
    create_table :tip_categories_and_tip_posts, :id => false do |t|
      t.integer :tip_category_id
      t.integer :tip_post_id
    end 
  end

  def down
    drap_table :tip_categories_and_tip_posts
  end
end
