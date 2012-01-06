class Admin::Book::ItemsController < AdminController
  def index
    @book_items = BookItem.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @book_item = BookItem.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @book_item = BookItem.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @book_item = BookItem.find(params[:id])
  end
  
  def destroy
    @book_item = BookItem.find(params[:id])
    @book_item.destroy

    respond_to do |format|
      format.html { redirect_to admin_route(admin_book_items_path) }
    end
  end
  
  def update
    @book_item = BookItem.find(params[:id])

    respond_to do |format|
      if @book_item.update_attributes(params[:book_item])        
        format.html { redirect_to admin_route(admin_book_item_path(@book_item)), :notice => 'Book Item was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end  
  end
  
  def create
    @book_item = BookItem.new(params[:book_item])    
    
    respond_to do |format|
      if @book_item.save
        format.html { redirect_to admin_route(admin_book_item_path(@book_item)), :notice => 'Book Item was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
