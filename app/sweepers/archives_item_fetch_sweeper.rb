class ArchivesItemFetchSweeper < ActionController::Caching::Sweeper
  observe ArchivesItemFetch
  
  def after_save(archives_item_fetch)
    expire_cache(archives_item_fetch)
  end
  
  def after_destroy(archives_item_fetch)
    expire_cache(archives_item_fetch)
  end
  
  def expire_cache(archives_item_fetch)
    Rails.logger.debug "================================>expire_cache： ArchivesItemFetchSweeper < ActionController::Caching::Sweeper"
#eg.#    expire_page :controller => 'javascripts', :action => 'dynamic_archives_item_fetchs', :format => 'js'
  end
end