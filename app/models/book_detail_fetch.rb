require 'iconv'

class BookDetailFetch < ActiveRecord::Base
  has_one :book_detail, :foreign_key => :from_uri, :primary_key => :url
  
  validates_uniqueness_of :url
  
  def self.conv_text(text, encoding)
    Iconv.conv('UTF-8//IGNORE',encoding.upcase!, text)
  end
  
  def fetch_detail
    book_detail = self.book_detail || BookDetail.new(:book_detail_fetch_id => self.id, 
      :from_uri => self.url, :from_site => self.from_site)
    
    uri_open = URI.parse(self.url)
    result_str = uri_open.read
      
    doc = Nokogiri::HTML(result_str)
    
    fetch_isbn = nil
    fetch_published_at = nil
    fetch_content_outline = nil
    fetch_content_author  = nil
    fetch_content_catelog = nil
    fetch_content_media_comment = nil
    
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
          
          node_content = node_text.sub(node_name, "").strip
          Rails.logger.debug "-------------------->#{node_content}"
          
          case node_name
          when "作　　者："
            
          when "ＩＳＢＮ："
            fetch_isbn = node_content            
          when "出版时间："
            fetch_published_at = Time.parse(node_content)
          when "版　　次："
            
          when "装　　帧："
            
          when "开　　本："
            
          when "所属分类："
            
          end
        end
      end
    
      #      价格抓取
      prices_node = doc.css("#book-price li")    
      fetch_price = prices_node.first.css("del").first.text.strip
      
      #      正文抓取
      doc.css("html body#book div.w div.right-extra div.m").each do |node|
        node_title = node.css(".mt h2")
        node_content = node.css(".mc .con")
        
        if !node_title.nil? && !node_content.nil? && node_title.any? && node_content.any?
          
          node_content_html = BookDetailFetch.conv_text(node_content.first.inner_html, result_str.charset)
          case node_title.first.text.strip
          when "内容简介"
            fetch_content_outline = node_content_html
          when "作者简介"
            fetch_content_author = node_content_html
          when "媒体评论"
            fetch_content_media_comment = node_content_html
          when "目录"
            fetch_content_catelog = node_content_html  
          end
        end
      end
      
      Rails.logger.debug "=========>#{fetch_price}"
    end    
    
    title_node = doc.css("html body#book div.w div.crumb a").last
    
    book_detail.title = title_node.text.strip
    book_detail.isbn = fetch_isbn
    book_detail.published_at = fetch_published_at
    
    book_detail.content_outline = fetch_content_outline
    book_detail.content_author = fetch_content_author
    book_detail.content_catelog = fetch_content_catelog
    book_detail.content_media_comment = fetch_content_media_comment
    book_detail.price = fetch_price
    book_detail.save
  end
end
