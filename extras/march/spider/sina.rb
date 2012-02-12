module March
  module Spider
    class Sina
      
      class << self
        def fetch_category(options={})
          base_uri = "http://roll.news.sina.com.cn/interface/rollnews_ch_out_interface.php?col=89&spec=&type=&ch=&k=&offset_page=0&offset_num=0&num=60&asc=&page=1"
          puts "fetch #{base_uri}"

          doc = March::Fetch::OpenByUri.open(base_uri)
#          _content = doc.content.sub("var jsonData = ", '')
          _content = doc.content
          puts "#{_content}"

          puts "#{URI::REGEXP::REL_URI.match(_content)}"
          unless _content.blank?
            
#            fetch_links = /http:\/\/*html/.match(doc.content)
#            fetch_links.each do |link|
#              begin
#                ArchivesItemFetch.fetch(:from_site => Website::FetchConfig::SITE_SINA,
#                  :from_uri => link, :force_update => true)                      
#              rescue
#                next
#              ensure
#                next
#              end
#            end
          end
        end 
      end
    end
  end
end