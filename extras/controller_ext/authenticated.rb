module ControllerExt
  module Authenticated
    protected
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= (login_from_session || login_from_cookie || login_from_basic_auth || false)
    end

    def current_user=(new_user)
      session[:user_id] = (new_user.nil? || new_user.is_a?(Symbol)) ? nil : new_user.id
      @current_user = new_user || nil
    end
    def login_required
      logged_in? || access_denied
    end

    #   登录的超链接
    def sign_in_url    
#      from = params[:from]
#      from = URI.escape(request.fullpath) if from.blank?
      "#{login_path}"
    end

    def access_denied
      respond_to do |format|
        format.html do
          store_location
          redirect_to sign_in_url
        end

        format.any(:js, :xml) do
          request_http_basic_authentication 'Web Password'
        end
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default, options={})
      redirect_to(session[:return_to] || default, options)
      session[:return_to] = nil
    end

    def login_from_session
      self.current_user = User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound 
      nil
    end

    def login_from_basic_auth
      authenticate_with_http_basic do |email, password|
        self.current_user = User.authenticate(email, password)
      end
    end

    def login_from_cookie
      user = cookies[:auth_token] && User.find_by_remember_token(cookies[:auth_token])
      if user && user.remember_token?
        user.remember_me
        cookies[:auth_token] = { :value => user.remember_token, :expires => user.remember_token_expires_at }
        self.current_user = user
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