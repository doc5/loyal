class UsersController < ApplicationController
  #确保登录
  before_filter :login_required, :only => [:password_edit, :password_update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, :notice => "User Created!" }
      else
        format.html {render "new"}
      end
    end 
  end
  
  
  #  账户密码编辑
  def password_edit
    @user = current_user
  end
  #  账户密码更新
  def password_update
    @user = current_user
    
    _user = params[:user]
    @user.old_password = _user[:old_password]
    @user.password = _user[:password]
    @user.password_confirmation = _user[:password_confirmation]
    
    respond_to do |format|
      if @user.modify_password
        format.html { redirect_to session[:return_to] || root_url, :notice => 'Password Updated.' }
      else
        format.html {render "password_edit"}
      end
    end 
  end
end
