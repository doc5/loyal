class Admin::Archives::ItemsController < AdminController
  def index
    @archives_items = ArchivesItem.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @archives_item = ArchivesItem.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @archives_item = ArchivesItem.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @archives_item = ArchivesItem.find(params[:id])
  end
  
  def destroy
    @archives_item = ArchivesItem.find(params[:id])
    @archives_item.destroy

    respond_to do |format|
      format.html { redirect_to admin_route(admin_archives_items_path) }
    end
  end
  
  def update
    @archives_item = ArchivesItem.find(params[:id])

    respond_to do |format|
      if @archives_item.update_attributes(params[:archives_item])        
        format.html { redirect_to admin_route(admin_archives_item_path(@archives_item)), :notice => 'Archives Item was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @archives_item = ArchivesItem.new(params[:archives_item])    
    
    respond_to do |format|
      if @archives_item.save
        format.html { redirect_to admin_route(admin_archives_item_path(@archives_item)), :notice => 'Archives Item was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
