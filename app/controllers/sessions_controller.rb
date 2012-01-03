class SessionsController < ApplicationController  
  def new
    @user_session = UserSession.new
    respond_to do |format|
      format.html 
    end
  end
  
  def destroy
    session_destroy
    respond_to do |format|
      format.html { redirect_to sessions[:return_to] || params[:return_to] || root_url }
    end
  end
  
  def create  
    @user_session = UserSession.new(params[:user_session])
    user_login @user_session.authenticate 
    respond_to do |format|
      if logged_in?
        format.html { redirect_back_or_default root_path, :notice => "Session Created!" }
      else
        flash[:error] = "Email Or Password Error"
        format.html { render :action => "new" }
      end
    end
  end
end
