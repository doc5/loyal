class Yuedu123::Archives::CategoriesController < Yuedu123Controller
  def show
    @archives_category = ArchivesCategory.find_by_url_name params[:url_name]
  end

end
