module March
  module Spider
    class Yuwendashi
      CATEGORIE_BASE_CONFIGS = {
        'qinggan' => {
          :name => "情感文章", :parent => nil,
          :url => "http://www.xiexingcun.com/meiwen/ShowClass.asp?ClassID=1699&page=", :page => 1
        }
      }
      
      class << self
        def fetch_category(options={})          
          cate_config = CATEGORIE_BASE_CONFIGS[options[:category]]
          return if cate_config.nil?
          
          (options[:page] || cate_config[:page]).to_i.downto((options[:down_page] || 1).to_i) do |i|
#            begin
              unless cate_config[:url].nil?
                base_uri = "#{cate_config[:url]}#{i}"
                puts "fetch #{base_uri}"

#                doc = March::Fetch::OpenByUri.open(base_uri)

#                text = open(base_uri).read
#                text = March::StringTools.conv_text('GB2312', text)
#                doc = Nokogiri::HTML(text)

                title_fetch2 = doc.css("html body table.center_tdbgall tbody tr td.main_tdbgall table tbody tr td.main_tdbg_575 table tbody tr td table tbody tr td table tbody tr td a") 
                title_fetch2.each do |title|
                  link = "http://www.xiexingcun.com#{title[:href]}"
                  puts "#{link}   --------------------------"
#                  if !link.blank? && link.include?(".html")                    
#                    begin
#                      ArchivesItemFetch.fetch(
#                        :from_site => Website::FetchConfig::SITE_YUWENDASHI,
#                        :from_uri => link, 
#                        :force_update => options[:force_update], 
#                        :fetch_category => cate_config[:name])                      
#                    rescue
#                      next
#                    ensure
#                      next
#                    end
#                  end
                end
              end
#            rescue
#              next
#            ensure
#              next
#            end
          end
        end
      end
    end
  end
end