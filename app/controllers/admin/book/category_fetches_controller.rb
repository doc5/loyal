class Admin::Book::CategoryFetchesController < AdminController
  def index
    @root_book_category_fetches = BookCategoryFetch.where(:parent_id => nil, 
      :site_type =>  (params[:site_type] || BookCategoryFetch::TYPE_DEFAULT)).order("created_at desc")
  end
  
  def show
    @book_category_fetch = BookCategoryFetch.find(params[:id])
  end
end
