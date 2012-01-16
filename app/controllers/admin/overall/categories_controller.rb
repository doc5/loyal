class Admin::Overall::CategoriesController < ApplicationController
  def index
    @overall_categories = OverallCategory.total_tree_struct
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @overall_category = OverallCategory.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @overall_category = OverallCategory.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @overall_category = OverallCategory.find(params[:id])
  end
  
  def destroy
    @overall_category = OverallCategory.find(params[:id])
    @overall_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_route(admin_overall_categories_path) }
    end
  end
  
  def update
    @overall_category = OverallCategory.find(params[:id])

    respond_to do |format|
      if @overall_category.update_attributes(params[:overall_category])        
        format.html { redirect_to admin_route(admin_overall_category_path(@overall_category)), :notice => 'Overall Category was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @overall_category = OverallCategory.new(params[:overall_category])    
    
    respond_to do |format|
      if @overall_category.save
        format.html { redirect_to admin_route(admin_overall_category_path(@overall_category)), :notice => 'Overall Category was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
