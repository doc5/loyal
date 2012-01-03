class ApplicationController < ActionController::Base
  include ControllerExt::Authenticated
  include ControllerExt::DomainRoute
  
  protect_from_forgery
  
end
