class Yuedu123::Archives::CategoriesController < Yuedu123Controller
  def show
    @archives_category = ArchivesCategory.find_by_url_name params[:url_name]
    @archives_item_fetches = @archives_category.paginate_tree_item_fetches(:page => params[:page])
    
    respond_to do |format|
      format.html
    end
  end
  
  def index
    @archives_categories = ArchivesCategory.root_categories
    
    respond_to do |format|
      format.html
    end
  end

end
