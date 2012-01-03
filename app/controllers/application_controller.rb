class ApplicationController < ActionController::Base
  include ControllerExt::Authenticated
  
  protect_from_forgery
  
end
