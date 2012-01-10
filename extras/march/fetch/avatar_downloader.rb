require "open-uri"
module March
  module Fetch
    class AvatarDownloader
#      attr_accessor :src
#      
#      def initialize(options={})
#        @src = options[:src]
#      end

      class << self
        def fetch(uri='http://img10.360buyimg.com/n0/10419/7a3b62a3-3575-4682-bedb-7c5ea6b060a0.jpg')
          extend_name = uri[/\.[^\.]+$/]
          
          data = open(uri){|f|
            f.read
          }

          open("/home/jinzhong/logo#{extend_name}","wb"){|f|f.write(data)}
        end
      end
    end
  end
end