class Yuedu123::Archives::FetchesController < Yuedu123Controller
  def show
    @archives_item_fetch = ArchivesItemFetch.find_by_uuid params[:uuid]
    
    @seo_title = @archives_item_fetch.title
  end
  
  def index
    @archives_item_fetches = ArchivesItemFetch.paginate :page => params[:page]
    
    @seo_title = "文章列表 第#{params[:page] || 1}页"
  end

end
