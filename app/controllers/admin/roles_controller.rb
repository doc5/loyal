class Admin::RolesController < AdminController
  def index
    @roles = Role.all
    respond_to do |format|
      format.html 
    end
  end

  def show
    @role = Role.find(params[:id])
    respond_to do |format|
      format.html 
    end
  end
  
  def edit
    @role = Role.find(params[:id])
  end
  
  def new
    @role = Role.new
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    respond_to do |format|
      format.html { redirect_to admin_route(admin_roles_path) }
    end
  end
  
  def update    
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to admin_route(admin_role_path(@role)), :notice => 'Role was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @role = Role.new(params[:role])
    
    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_route(admin_role_path(@role)), :notice => 'Role was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
