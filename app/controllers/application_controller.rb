class ApplicationController < ActionController::Base
  include ControllerExt::Authenticated
  include ControllerExt::DomainRoute
  include ControllerExt::Languaged
  
  protect_from_forgery
  
  
  def render_404
    
  end
end
