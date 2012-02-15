module March
  module Spider
    class Yuwendashi
      CATEGORIE_BASE_CONFIGS = {
        'qingganmeiwen' => {
          :name => "情感美文", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/meiwen/ShowClass.asp?ClassID=1699&page=", 
          :page => 15, #all not
          :apply => true
        },
        'shenghuomeiwen' => {
          :name => "生活美文", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/meiwen/ShowClass.asp?ClassID=1772&page=", 
          :page => 10, #all not
          :apply => true
        },
        'wenhuameiwen' => {
          :name => "文化美文", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/meiwen/ShowClass.asp?ClassID=1773&page=", 
          :page => 5, 
          :apply => false
        },
        'zhihuimeiwen' => {
          :name => "智慧美文", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/meiwen/ShowClass.asp?ClassID=1700&page=", 
          :page => 2,  #2
          :apply => true
        },
        'shehuiwanxiang' => {
          :name => "社会万象", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/wenhui/ShowClass.asp?ClassID=2001&page=", 
          :page => 2, 
          :apply => true
        },
        'lishitiankong' => {
          :name => "历史天空", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/wenhui/ShowClass.asp?ClassID=2002&page=", 
          :page => 2, 
          :apply => true
        },
        'jiankangzhiyou' => {
          :name => "健康之友", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/wenhui/ShowClass.asp?ClassID=2003&page=", 
          :page => 2, 
          :apply => true
        },
        'yiyucaifeng' => {
          :name => "异域采风", 
          :parent => nil,
          :url => "http://www.xiexingcun.com/wenhui/ShowClass.asp?ClassID=2004&page=", 
          :page => 2, 
          :apply => true
        }
      }
      
      class << self
        def classify_categories_map
          return @_cache_classify_categories_map if defined?@_cache_classify_categories_map
          @_cache_classify_categories_map = Hash.new
          CATEGORIE_BASE_CONFIGS.each do |k, config|
            @_cache_classify_categories_map[config[:name]] = ArchivesCategory.find_by_flag_name("haowen-#{k}")
          end
          @_cache_classify_categories_map
        end
        
        def classify_category(item)
          _category = self.classify_categories_map[item.fetch_category]
          if _category.present? && !item.category_ids.include?(_category.id)
            Rails.logger.debug "归类ID:#{item.id}==========> #{_category.name} 更新"
            item.categories = [_category]
            item.save
          else
            Rails.logger.debug "ID:#{item.id}==========> category 无更新"
          end
        end
#        归类所有的文章
# => March::Spider::Yuwendashi.classify_categories
        def classify_categories(options={})          
          ArchivesItemFetch.find_all_by_from_site(Website::FetchConfig::SITE_YUWENDASHI).each do |item|
            self.classify_category(item)
          end
          true
        end
        
        
        
        def fetch
          CATEGORIE_BASE_CONFIGS.each do |cate, config|
            fetch_category(:category => cate) if config[:apply]
          end
        end
        
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