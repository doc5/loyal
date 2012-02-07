class ApplicationController < ActionController::Base
  include ControllerExt::Authenticated
  include ControllerExt::DomainRoute
  include ControllerExt::Languaged
  include March::Tools::SystemTools
  
  protect_from_forgery
  
  before_filter :init_seo_info
  
  around_filter :memory_look
  
#  def render_404    
#  end

  protected
  def init_seo_info
    @seo_title = ""
    @seo_keys = ""
    @seo_desc = ""
  end
end
