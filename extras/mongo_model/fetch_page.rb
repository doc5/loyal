require 'open-uri'
require 'rubygems'
require 'iconv'
require 'sanitize'

module MongoModel
  class FetchPage
    include MongoMapper::Document
    
    key :uri, String, :unique => true
    key :status, Integer, :default => 0
    
    key :content, String
    
    timestamps! # HECK YES
    
    self.ensure_index [[:uri, 1]], :unique => true
    self.ensure_index [[:uri, 1], [:status, 1]], :unique => true
    
    class << self
      def do_fetch(uri, force=false)   
        fetch_page = MongoModel::FetchPage.find_by_uri(uri.strip!)
        
#        if fetch_page.nil? || force
#          uri_open = URI.parse(uri)
#          str = uri_open.read
          
#          charset = str.charset.upcase
#          if "GBK" != charset
#            str = str.sub!(/gb2312/, 'gb18030')
##            str = Iconv.iconv(charset,"UTF-8", str)  
#          end
          
#          puts str
#          str.sub!(/gb2312/, 'gb18030')

#          puts str.class
#          puts str.base_uri
#          puts str.content_type
#          puts str.charset
#          puts str.content_encoding
#          puts str.last_modified           
#        end          
        
        if fetch_page.nil? || force          
          uri_open = URI.parse(uri)
          str = uri_open.read
        end
        
        if fetch_page.nil?          
          fetch_page = MongoModel::FetchPage.new(:uri => uri.strip!) 
        end
        
        fetch_page.content = str
        fetch_page.save
      end
    end
  end
end

#http://ruby-doc.org/stdlib-1.9.3/libdoc/net/http/rdoc/Net/HTTP.html
#
#uri = URI('http://example.com/index.html')
#params = { :limit => 10, :page => 3 }
#uri.query = URI.encode_www_form(params)
#
#res = Net::HTTP.get_response(uri)
#puts res.body if res.is_a?(Net::HTTPSuccess)