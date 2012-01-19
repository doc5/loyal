class Tip::PostsController < TipController
  def show
    @tip_post = TipPost.find(params[:id])
  end
  
  def index
    @tip_posts = TipPost.all
  end
  
  def new
    @tip_post = TipPost.new
  end
  
  def create
    @tip_post = TipPost.new(params[:tip_post])
    
    respond_to do |format|
      if @tip_post.save
        format.html { redirect_to tip_route(tip_post_path(:id => @tip_post.id)), :notice => '新建成功！' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @tip_post = TipPost.find(params[:id])
  end
  
  def update
    @tip_post = TipPost.find(params[:id])
    
    respond_to do |format|
      if @tip_post.update_attributes(params[:tip_post])
        format.html { redirect_to tip_route(tip_post_path(:id => @tip_post.id)), :notice => '更新成功！' }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @tip_post = TipPost.find(params[:id])
    @tip_post.destroy

    respond_to do |format|
      format.html { redirect_to tip_posts_path, :notice => '删除成功！' }
    end
  end

end
