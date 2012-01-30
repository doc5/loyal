class Yuedu123::Archives::HomeController < Yuedu123Controller
  def index
    @archives_item_fetches = ArchivesItemFetch.paginate :page => params[:page]
  end

end
