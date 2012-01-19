class Admin::Tip::CategoriesController < AdminController
  def index
    @tip_categories = TipCategory.total_tree_struct
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @tip_category = TipCategory.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @tip_category = TipCategory.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @tip_category = TipCategory.find(params[:id])
  end
  
  def destroy
    @tip_category = TipCategory.find(params[:id])
    @tip_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_route(admin_tip_categories_path) }
    end
  end
  
  def update
    @tip_category = TipCategory.find(params[:id])

    respond_to do |format|
      if @tip_category.update_attributes(params[:tip_category])        
        format.html { redirect_to admin_route(admin_tip_category_path(@tip_category)), :notice => 'Tip Category was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @tip_category = TipCategory.new(params[:tip_category])    
    
    respond_to do |format|
      if @tip_category.save
        format.html { redirect_to admin_route(admin_tip_category_path(@tip_category)), :notice => 'Tip Category was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
