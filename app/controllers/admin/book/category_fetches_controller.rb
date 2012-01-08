class Admin::Book::CategoryFetchesController < AdminController
  def index
    @root_book_category_fetches = BookCategoryFetch.where(:parent_id => nil, 
      :from_site =>  (params[:from_site] || BookCategoryFetch::TYPE_DEFAULT)).order("position asc")
  end
  
  def show
    @book_category_fetch = BookCategoryFetch.find(params[:id])
  end
end
