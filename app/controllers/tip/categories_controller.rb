class Tip::CategoriesController < TipController
  def index
    @tip_categories = TipCategory.categories_self_and_children #.root_categories
  end

  def show
    @tip_category = TipCategory.find(params[:id])
    @tip_posts = @tip_category.tip_posts
  end
end
