class Yuedu123::Archives::CategoriesController < Yuedu123Controller
  def show
    @archives_category = ArchivesCategory.find_by_url_name params[:url_name]
    @archives_item_fetches = @archives_category.paginate_tree_item_fetches(:page => params[:page])
    
    @seo_title = "[分类] #{@archives_category.name}"
    
    respond_to do |format|
      format.html
    end
  end
  
  def index
    @archives_categories = ArchivesCategory.root_categories
    
    @seo_title = "文章分类导航"
    
    respond_to do |format|
      format.html
    end
  end

end
