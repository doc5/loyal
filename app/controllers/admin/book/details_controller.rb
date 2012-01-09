class Admin::Book::DetailsController < AdminController
  def index
    @book_details = BookDetail.paginate(:page => params[:page], :order => "id desc")
  end
  
  def show
    @book_detail = BookDetail.find(params[:id])
  end
end
