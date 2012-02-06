module ControllerExt
  module Authenticated
    protected
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= (login_from_session || login_from_cookie || login_from_basic_auth)
    end

    def user_login(new_user)
      session[:user_id] = (new_user.nil? || new_user.is_a?(Symbol)) ? nil : new_user.id
      
      Rails.logger.debug "#{session[:user_id]} ====================================> "
      @current_user = new_user || nil
    end
    
    def login_required
      logged_in? || access_denied
    end
    
    def admin_required
      logged_in? && current_user.admin? || access_denied("Need Admin!")
    end

    #   登录的超链接
    def sign_in_url    
      #      from = params[:from]
      #      from = URI.escape(request.fullpath) if from.blank?
      "#{www_route(login_path)}"
    end

    def access_denied(notice="Require Sign in!")
      respond_to do |format|
        format.html do
          store_location
          redirect_to sign_in_url, :notice => notice
        end

        format.any(:js, :xml) do
          request_http_basic_authentication 'Web Password'
        end
      end
    end

    def store_location
      #session[:return_to] = request.path
    end

    def redirect_back_or_default(default, options={})
      redirect_to(session[:return_to] || default, options)
      session[:return_to] = nil
    end

    def login_from_session
      user_login(User.find(session[:user_id])) if session[:user_id]
    rescue ActiveRecord::RecordNotFound 
      nil
    end

    def login_from_basic_auth
      authenticate_with_http_basic do |email, password|
        user_login User.authenticate(email, password)
      end
    end

    def login_from_cookie
      user = cookies[:auth_token] && User.find_by_remember_token(cookies[:auth_token])
      if user && user.remember_token?
        user.remember_me
        cookies[:auth_token] = { :value => user.remember_token, :expires => user.remember_token_expires_at }
        user_login user
      end
    end
    
    def session_destroy
      sessions.delete(:user_id)
      cookies.delete(:auth_token)
    end

    def self.included(base)
      base.send :helper_method, :logged_in?, :current_user, :sign_in_url
    end
  end
end