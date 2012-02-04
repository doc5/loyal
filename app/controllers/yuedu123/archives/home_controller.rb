class Yuedu123::Archives::HomeController < Yuedu123Controller
  def index
    @seo_title = "读文章首页 - #{Website::Info.yuedu123_name}"
  end

end
