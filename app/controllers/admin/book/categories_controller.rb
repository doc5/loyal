class Admin::Book::CategoriesController < AdminController
  def index
    @book_categories = BookCategory.total_tree_struct
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @book_category = BookCategory.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @book_category = BookCategory.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @book_category = BookCategory.find(params[:id])
  end
  
  def destroy
    @book_category = BookCategory.find(params[:id])
    @book_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_route(admin_book_categories_path) }
    end
  end
  
  def update
    @book_category = BookCategory.find(params[:id])

    respond_to do |format|
      if @book_category.update_attributes(params[:book_category])        
        format.html { redirect_to admin_route(admin_book_category_path(@book_category)), :notice => 'Book Category was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @book_category = BookCategory.new(params[:book_category])    
    
    respond_to do |format|
      if @book_category.save
        format.html { redirect_to admin_route(admin_book_category_path(@book_category)), :notice => 'Book Category was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def fetches
    
  end
end
