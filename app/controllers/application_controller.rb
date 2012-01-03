class ApplicationController < ActionController::Base
  include ControllerExt::Authenticated
  include ControllerExt::DomainRoute
  include ControllerExt::Languaged
  
  protect_from_forgery
  
end
