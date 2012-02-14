module March
  module Spider
    class Yuwendashi
      CATEGORIE_BASE_CONFIGS = {
        'qinggan' => {
          :name => "情感文章", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/meiwen/ShowClass.asp?ClassID=1699&page=", :page => 1
        }
      }
      
      class << self
        def fetch_category(options={})          
          cate_config = CATEGORIE_BASE_CONFIGS[options[:category]]
          return if cate_config.nil?
          
          (options[:page] || cate_config[:page]).to_i.downto((options[:down_page] || 1).to_i) do |i|
            begin
              unless cate_config[:url].nil?
                base_uri = "#{cate_config[:url]}#{i}"
                puts "fetch #{base_uri}"

                doc = March::Fetch::OpenByUri.open(base_uri)
                
                _links = doc.css(".main_tdbg_575")[0].css("a")
                puts "============> #{_links.length}"
                _links.each do |a|
                  _link = "http://www.xiexingcun.com#{a.attr("href")}"
                  puts "#{_link}   --------------------------#{cate_config[:name]}"
                  if !_link.blank? && !_link.include?(".html")
                    begin
                      ArchivesItemFetch.fetch(
                        :from_site => Website::FetchConfig::SITE_YUWENDASHI,
                        :from_uri => _link, 
                        :fetch_category => cate_config[:name])
                    rescue
                      next
                    ensure
                      next
                    end
                  end
                end
              end
            rescue
              next
            ensure
              next
            end
          end
        end
      end
    end
  end
end