class Apps::ItemsController < AppsController
  
  
  def reflect
    app_type = params[:app_type]
    app_flag = params[:app_flag]
    
    if app_type == 'music'
      @seo_title = "Goolge正版音乐！" if app_flag == "google"
    end
    
    if app_type == 'radio'
      @seo_title = "豆瓣FM！" if app_flag == "douban"
    end
    
    respond_to do |format|
      format.html{render "/apps/items/reflect/#{app_type}/#{app_flag}"}
    end
    
  end
end
