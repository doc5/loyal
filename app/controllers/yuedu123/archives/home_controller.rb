class Yuedu123::Archives::HomeController < Yuedu123Controller
  def index
    @seo_title = "#{Website::Info.yuedu123_name} - 读文章首页"
  end

end
