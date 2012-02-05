class Yuedu123::HomeController < Yuedu123Controller
  def index    
    redirect_to archives_route(root_path)
#    @seo_title = "#{Website::Info.yuedu123_name}"
  end
  
#  文章搜索
  def search
    @query_words = params[:query]
    
    if @query_words.present?
      @query_results = ActsAsFerret.find(@query_words, 'shared', :page => params[:page], :per_page => 20)
      
      @seo_title = "阅读搜索_#{@query_words} - #{Website::Info.yuedu123_name}"
    else
      @seo_title = "阅读搜索 - #{Website::Info.yuedu123_name}"
    end
  end
end
