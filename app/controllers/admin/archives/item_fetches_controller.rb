class Admin::Archives::ItemFetchesController < AdminController
  def index
    @archives_item_fetches = ArchivesItemFetch.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @archives_item_fetch = ArchivesItemFetch.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @archives_item_fetch = ArchivesItemFetch.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @archives_item_fetch = ArchivesItemFetch.find(params[:id])
  end
  
  def destroy
    @archives_item_fetch = ArchivesItemFetch.find(params[:id])
    @archives_item.destroy

    respond_to do |format|
      format.html { redirect_to admin_route(admin_archives_item_fetch_path) }
    end
  end
  
  def update
    @archives_item_fetch = ArchivesItemFetch.find(params[:id])

    respond_to do |format|
      if @archives_item_fetch.update_attributes(params[:archives_item_fetch])        
        format.html { redirect_to admin_route(admin_archives_item_fetch_path(@archives_item_fetch)), :notice => 'Archives Item Fetch was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @archives_item_fetch = ArchivesItemFetch.new(params[:archives_item_fetch])    
    
    respond_to do |format|
      if @archives_item_fetch.save
        format.html { redirect_to admin_route(admin_archives_item_fetch_path(@archives_item_fetch)), :notice => 'Archives Item Fetch was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
