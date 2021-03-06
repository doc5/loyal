class Yuedu123::HomeController < Yuedu123Controller
  def index    
    redirect_to archives_route(root_path)
    
#    @seo_title = "#{Website::Info.yuedu123_name}"
  end
  
#  文章搜索
  def search
    @query_words = params[:query]
    
    if @query_words.present?
      @query_words_used = RMMSeg::SimpleAlgorithm.new(@query_words).segment.join(" ")
      @query_results = ActsAsFerret.find(
        @query_words_used, 
        'shared', 
        {:page => params[:page], :per_page => 20, :lazy => true}, 
        {}
      )
      
      @seo_title = "阅读搜索_#{@query_words} - #{Website::Info.yuedu123_name}"
    else
      @seo_title = "阅读搜索 - #{Website::Info.yuedu123_name}"
    end
  end
end
