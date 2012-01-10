require "uri"

class Publisher < ActiveRecord::Base
  has_one :book_fetch_url_360buy, :class_name => "BookFetchUrl", :as => :resource, :conditions => ["from_site=?", Website::BookConfig::SITE_360BUY]
  has_many :book_details
  
  validates_presence_of :name, :role_type
  validates_uniqueness_of :name, :scope => [:name, :role_type]
  
  ROLE_TYPE_BOOK = 0 #图书出版社
  
  class << self
    def fetch_touch(options={})
      role_type = options[:role_type] || ROLE_TYPE_BOOK
      publisher = Publisher.find_by_name_and_role_type(options[:name].strip, role_type) || Publisher.new
      
      publisher.name = options[:name]
      publisher.role_type = role_type
      
      publisher.save
          
      case options[:from_site]
      when Website::BookConfig::SITE_360BUY
        url = "http://www.360buy.com/publish/#{URI.encode(options[:name])}_1.html"
        
        fetch_url = publisher.book_fetch_url_360buy
      end
      
      fetch_url ||= BookFetchUrl.new({
          :resource_type => "Publisher", 
          :resource_id => publisher.id, 
          :url => url,
          :from_site => options[:from_site]
        })
      
      fetch_url.save
      publisher
    end
  end
end
