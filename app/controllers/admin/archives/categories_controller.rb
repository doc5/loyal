class Admin::Archives::CategoriesController < AdminController
  def index
    @archives_categories = ArchivesCategory.total_tree_struct
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @archives_category = ArchivesCategory.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @archives_category = ArchivesCategory.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @archives_category = ArchivesCategory.find(params[:id])
  end
  
  def destroy
    @archives_category = ArchivesCategory.find(params[:id])
    @archives_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_route(admin_archives_categories_path) }
    end
  end
  
  def update
    @archives_category = ArchivesCategory.find(params[:id])

    respond_to do |format|
      if @archives_category.update_attributes(params[:archives_category])        
        format.html { redirect_to admin_route(admin_archives_category_path(@archives_category)), :notice => 'Archives Category was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @archives_category = ArchivesCategory.new(params[:archives_category])    
    
    respond_to do |format|
      if @archives_category.save
        format.html { redirect_to admin_route(admin_archives_category_path(@archives_category)), :notice => 'Archives Category was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
