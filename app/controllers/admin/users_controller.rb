# -*- encoding : utf-8 -*-
class Admin::UsersController < AdminController
  
  def index
    @users = User.paginate :page => params[:page], :per_page => params[:per]
    respond_to do |format|
      format.html 
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html 
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_route(admin_users_path) }
    end
  end
  
  def update    
    params[:user][:role_ids] ||= []
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_route(admin_user_path(@user)), :notice => 'User was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    
    params[:user][:role_ids] ||= []
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_route(admin_user_path(@user)), :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end