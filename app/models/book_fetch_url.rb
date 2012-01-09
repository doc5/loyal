class BookFetchUrl < ActiveRecord::Base
  validates_presence_of :resource_type, :resource_id, :url, :from_site
end
