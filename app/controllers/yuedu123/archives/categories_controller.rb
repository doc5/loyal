class Yuedu123::Archives::CategoriesController < Yuedu123Controller
  def show
    @archives_category = ArchivesCategory.find_by_url_name params[:url_name]
    
    respond_to do |format|
      format.html
    end
  end
  
  def index
    @archives_categories = ArchivesCategory.total_tree_struct
    
    respond_to do |format|
      format.html
    end
  end

end
