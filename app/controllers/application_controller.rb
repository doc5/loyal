class ApplicationController < ActionController::Base
  include ControllerExt::Authenticated
  include ControllerExt::DomainRoute
  include ControllerExt::Languaged
  include March::Tools::SystemTools
  before_filter :init_application_controller
  
#  has_mobile_fu(true)
  
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
  
  def init_application_controller
    prepend_view_path "app/formats/mobile"
  end
end
