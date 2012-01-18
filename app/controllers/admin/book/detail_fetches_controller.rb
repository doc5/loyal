class Admin::Book::DetailFetchesController < AdminController
  def index
    @book_detail_fetches = BookDetailFetch.paginate(:page => params[:page])
  end
  
  def show
    @book_detail_fetch = BookDetailFetch.find(params[:id])
  end
end
