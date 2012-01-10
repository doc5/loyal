require 'open-uri'
require 'iconv'
require 'sanitize'

class BookDetailFetch < ActiveRecord::Base
  has_one :book_detail, :foreign_key => :from_uri, :primary_key => :url
  
  validates_presence_of :from_site
  validates_uniqueness_of :url  
  
  def self.conv_text(text, encoding)
    Iconv.conv('UTF-8//IGNORE', encoding.upcase!, text)
  end
  
  def fetch_detail
    book_detail = self.book_detail || BookDetail.new(:book_detail_fetch_id => self.id, 
      :from_uri => self.url, :from_site => self.from_site)
    
    uri_open = URI.parse(self.url)
    result_str = uri_open.read
      
    doc = Nokogiri::HTML(result_str)
    
    fetch_isbn = nil
    fetch_published_at = nil
    fetch_format_tag = nil
    fetch_format_paper = nil
    fetch_author_info = nil
    fetch_publisher_name = nil
    fetch_revision = nil
    fetch_content_hash = {}
    fetch_category_ids_array = Array.new
    
    case book_detail.from_site
      #      =======================================> SITE_360BUY
    when Website::BookConfig::SITE_360BUY
      summary_node = doc.css("#summary")
      summary_list_nodes = summary_node.css("li")
      summary_list_nodes.each do |node|  
        node_name_span = node.css("span")
        if !node_name_span.nil? && node_name_span.any?
          node_name = node_name_span.first.text.strip
          node_text = node.text
#          node_html = node.inner_html
          
          node_content_text = node_text.sub(node_name, "").strip
          Rails.logger.debug "-#{node_name}------------------->#{node_content_text}"
          
          unless node_name.blank?
            case node_name
            when "作　　者："
              fetch_author_info = node_content_text
            when /出\s*版\s*社：/
              fetch_publisher_name = node_content_text
            when "ＩＳＢＮ："
              fetch_isbn = node_content_text            
            when "出版时间："
              fetch_published_at = Date.parse(node_content_text) unless node_content_text.blank?
            when "版　　次："
              fetch_revision = node_content_text
            when "装　　帧："
              fetch_format_tag = node_content_text
            when "开　　本："
              fetch_format_paper = node_content_text
            when "所属分类："
              cate_doc = Nokogiri::HTML(BookDetailFetch.conv_text(node.inner_html, result_str.charset))
              cate_doc.css("a").each_with_index do |node, i|
                if i % 3 == 2
                  cate = BookCategoryFetch.find_by_url(node.attr("href"))
                  fetch_category_ids_array << cate.id unless cate.nil?
                end
              end              
            end
          end
        end
      end
    
      #      价格抓取
      prices_node = doc.css("#book-price li")    
      fetch_price = prices_node.first.css("del").first.text.strip if prices_node.any?
      
      #      正文抓取
      doc.css("html body#book div.w div.right-extra div.m").each do |node|
        node_title = node.css(".mt h2")
        node_content = node.css(".mc .con")
        
        if !node_title.nil? && !node_content.nil? && node_title.any? && node_content.any?
          
          node_content_html = BookDetailFetch.conv_text(node_content.first.inner_html, result_str.charset)
          case node_title.first.text.strip
          when "内容简介"
            fetch_content_hash[BookDetail::CONTENT_OUTLINE]       = node_content_html
          when "作者简介"
            fetch_content_hash[BookDetail::CONTENT_AUTHOR]        = node_content_html
          when "媒体评论"
            fetch_content_hash[BookDetail::CONTENT_MEDIA_COMMENT] = node_content_html
          when "目录"
            fetch_content_hash[BookDetail::CONTENT_CATELOG]       = node_content_html
          when "精彩书摘"            
            fetch_content_hash[BookDetail::CONTENT_NICE_PICK]     = node_content_html
          when "前言"            
            fetch_content_hash[BookDetail::CONTENT_FOREWORD]      = node_content_html
          end
        end
      end
      
      Rails.logger.debug "=========>#{fetch_price}"
    end    
    
    title_node = doc.css("html body#book div.w div.crumb a").last
    
    book_detail.title = title_node.text.strip
    book_detail.isbn = fetch_isbn
    book_detail.author_info = fetch_author_info
    book_detail.published_at = fetch_published_at
    book_detail.format_tag = fetch_format_tag
    book_detail.format_paper = fetch_format_paper
    book_detail.revision = fetch_revision
    book_detail.book_category_fetch_ids = fetch_category_ids_array
    
    unless fetch_publisher_name.nil?
      publisher = Publisher.fetch_touch(
        :role_type => Publisher::ROLE_TYPE_BOOK, 
        :name => fetch_publisher_name,
        :from_site => book_detail.from_site
      )
      
      Rails.logger.debug "*********==================>#{publisher.name}|#{publisher.id}"
      
      book_detail.publisher_id = publisher.id unless publisher.nil?
#      Publisher.reset_counters(publisher.id, :book_details)
    end
      
    book_detail.content_hash = fetch_content_hash    
    book_detail.price = fetch_price
    book_detail.sync_item_by_isbn
    book_detail.save
  end
end
