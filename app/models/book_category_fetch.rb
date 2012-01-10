require 'open-uri'
require 'iconv'
require 'sanitize'

class BookCategoryFetch < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree
  
  belongs_to :book_category
  has_and_belongs_to_many :book_details
  
  validates_uniqueness_of :url    
  validates_presence_of :from_site
  
  TYPE_DEFAULT = Website::BookConfig::SITE_360BUY
  
  CATEGORY_CONFIGS = {
    Website::BookConfig::SITE_360BUY => {:url => "http://www.360buy.com/book/booksort.aspx", :name => "京东商城图书"}
  }
  
  def fetch_details(options={})
    uri_open = URI.parse(self.url)
    result_str = uri_open.read
      
    doc = Nokogiri::HTML(result_str)
    
    item_nodes = doc.css("html body#book div.w div.right-extra div#plist.m div.item")
    item_nodes.each do |item_node|
      title_node = item_node.css("dl dt.p-name a")
      fetch_title = title_node.first.text
      fetch_url = title_node.first.attr("href")
      
      detail_fetch = BookDetailFetch.find_by_url(fetch_url) || 
        BookDetailFetch.new(:url => fetch_url, :title => fetch_title)
      
      detail_fetch.from_site = self.from_site      
      
      Rails.logger.debug "title===>#{fetch_title}"
      Rails.logger.debug "url===>#{fetch_url}\n"
      
      detail_fetch.save   
      
      detail_fetch.fetch_detail if options[:fetch_detail]
    end
  end
  
  class << self
    def fetch_360buy_categories(force=false)
      category_url = CATEGORY_CONFIGS[Website::BookConfig::SITE_360BUY][:url]
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
        linker.position = i
        linker.name = fetch_name
        linker.from_site = Website::BookConfig::SITE_360BUY
        linker.parent_id = nil
        
        linker.save
        
        Rails.logger.debug "url====> #{fetch_url}"
        Rails.logger.debug "name====> #{fetch_name}"
        Rails.logger.debug "parent_id====> #{linker.parent_id}"
        
        dd_node.css("em a").each_with_index do |node, ii|
          node_name = node.text
          node_url = node.attr("href").to_s
          
          new_linker = BookCategoryFetch.find_by_url(node_url) || BookCategoryFetch.new
          new_linker.url = node_url
          new_linker.position = ii
          new_linker.name = node_name
          new_linker.from_site = Website::BookConfig::SITE_360BUY
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
