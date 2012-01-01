# -*- encoding : utf-8 -*-
require 'rss/2.0'
require 'open-uri'
require 'rubygems'
require 'iconv'
require 'sanitize'
require 'opml'

module March
  module Fetch
    #    Rss抓取
    class RssSpider
      attr_accessor :uri, :feed
      def initialize(options={})
        @uri = options[:uri]        
      end
      
      def save
        begin
          text = open(uri).read
          text.sub!(/gb2312/, 'gb18030')
          @feed = RSS::Parser.parse(text.to_s, false)
        rescue
#            for i in 1..5
#              retry 
#            end
        end
      end
    end
  end
end
