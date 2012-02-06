class Yuedu123::Archives::FetchesController < Yuedu123Controller
  def show
    @archives_item_fetch = ArchivesItemFetch.find_by_uuid params[:uuid]
    
    if @archives_item_fetch.first_category
      @seo_title = "《#{@archives_item_fetch.title}》- #{@archives_item_fetch.first_category.name}"
    else
      @seo_title = "《#{@archives_item_fetch.title}》"
    end
  end
  
  def index
    @archives_item_fetches = ArchivesItemFetch.paginate :page => params[:page], :order => "created_at DESC"
    
    @seo_title = "文章列表 第#{params[:page] || 1}页"
  end

end
