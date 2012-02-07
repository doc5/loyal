class Yuedu123::Archives::FetchesController < Yuedu123Controller
  def show
    @archives_item_fetch = ArchivesItemFetch.find_by_uuid params[:uuid]
    
    if @archives_item_fetch.first_category
      @seo_title = "《#{@archives_item_fetch.title}》- #{@archives_item_fetch.first_category.name} - #{Website::Info.yuedu123_name}"
    else
      @seo_title = "《#{@archives_item_fetch.title}》"
    end
    
    @seo_desc = "#{@archives_item_fetch.shared_searcher_outline}"
  end
end