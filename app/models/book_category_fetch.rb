require 'open-uri'
require 'iconv'
require 'sanitize'

class BookCategoryFetch < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree
  
  has_and_belongs_to_many :book_categories
  
  validates_uniqueness_of :url
  
  TYPE_JINGDONG = 0
  
  TYPE_DEFAULT = TYPE_JINGDONG
  
  CATEGORY_CONFIGS = {
    TYPE_JINGDONG => {:url => "http://www.360buy.com/book/booksort.aspx", :name => "京东商城图书"}
  }
  
  class << self
    def fetch_360buy(force=false)
      category_url = CATEGORY_CONFIGS[TYPE_JINGDONG][:url]
      uri_open = URI.parse(category_url)
      result_str = uri_open.read
      
      doc = Nokogiri::HTML(result_str)
      dt_nodes = doc.css("html body#book div.w div#booksort.m div.mc dl dt")
      dd_nodes = doc.css("html body#book div.w div#booksort.m div.mc dl dd")
      
      (0...dt_nodes.size).each do |i|
        dt_node = dt_nodes[i]
        dd_node = dd_nodes[i]
        
        fetch_name = dt_node.css("a").text
        fetch_url = dt_node.css("a").attr("href").to_s
        
        linker = BookCategoryFetch.find_by_url(fetch_url) || BookCategoryFetch.new
        
        linker.url = fetch_url
        linker.name = fetch_name
        linker.site_type = TYPE_JINGDONG
        linker.parent_id = nil
        
        linker.save
        
        Rails.logger.debug "url====> #{fetch_url}"
        Rails.logger.debug "name====> #{fetch_name}"
        Rails.logger.debug "parent_id====> #{linker.parent_id}"
        
        dd_node.css("em a").each do |node|
          node_name = node.text
          node_url = node.attr("href").to_s
          
          new_linker = BookCategoryFetch.find_by_url(node_url) || BookCategoryFetch.new
          new_linker.url = node_url
          new_linker.name = node_name
          new_linker.site_type = TYPE_JINGDONG
          new_linker.parent_id = linker.id
          new_linker.save
          
          
          Rails.logger.debug "url==========> #{new_linker.url}"
          Rails.logger.debug "name==========> #{new_linker.name}"
          Rails.logger.debug "parent_id==========> #{new_linker.parent_id}"
        end
      end
      rebuild! if force
    end
  end  
end
