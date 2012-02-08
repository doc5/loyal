class ArchivesItemFetchObserver < ActiveRecord::Observer
  observe :archives_item_fetch
  
#  http://api.rubyonrails.org/classes/ActiveRecord/Observer.html

#  def after_create(contact)
#    contact.logger.info('New contact added!')
#  end
#
#  def after_destroy(contact)
#    contact.logger.warn("Contact with an id of #{contact.id} was destroyed!")
#  end
#  def after_update(record)
#    AuditTrail.new(record, "UPDATED")
#  end
  
  def after_save(archives_item_fetch)
    expire_cache(archives_item_fetch)
  end
  
  def after_destroy(archives_item_fetch)
    expire_cache(archives_item_fetch)
  end
  
  def expire_cache(archives_item_fetch)
    Rails.logger.debug "================================> 更新对象的缓存"
  end
end