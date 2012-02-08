class ArchivesCategoryObserver < ActiveRecord::Observer
  observe :archives_category
  
#  http://api.rubyonrails.org/classes/ActiveRecord/Observer.html
  
  def after_save(archives_category)
    expire_cache(archives_category)
  end
  
  def after_destroy(archives_category)
    expire_cache(archives_category)
  end
  
  def expire_cache(archives_category)
    Rails.logger.debug "================================> 更新对象archives_category的缓存"
  end
end