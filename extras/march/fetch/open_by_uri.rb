require 'open-uri'

module March
  module Fetch
    class OpenByUri
      class << self
        def open(uri=nil)
          return nil if uri.nil?
          
          uri_open = URI.parse(uri)
          result_str = uri_open.read
          Nokogiri::HTML(result_str)
        end
      end
    end
  end
end