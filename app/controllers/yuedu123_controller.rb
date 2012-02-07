class Yuedu123Controller < ApplicationController
  
  protected
  def init_seo_info
    @seo_title = ""
    @seo_keys = "#{Website::Info.yuedu123_keys}"
    @seo_desc = "#{Website::Info.yeudu123_desc}"
  end
end
