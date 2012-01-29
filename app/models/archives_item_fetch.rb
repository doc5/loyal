class ArchivesItemFetch < ActiveRecord::Base
  validates_uniqueness_of :unique_url, :message =>"已经被占用了"
end
