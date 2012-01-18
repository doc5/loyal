class Apps::ItemsController < AppsController
  
  
  def reflect
    app_type = params[:app_type]
    app_flag = params[:app_flag]
    
    if app_type == 'music'
      case app_flag
      when "google"
        @seo_title = "Goolge正版音乐！" 
      when "soso"
        @seo_title = "SOSO音乐播放器！" 
      end
    end
    
    if app_type == 'radio'
      @seo_title = "豆瓣FM！" if app_flag == "douban"
    end
    
    respond_to do |format|
      format.html{render "/apps/items/reflect/#{app_type}/#{app_flag}"}
    end
    
  end
end
