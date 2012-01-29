module March
  module Spider
    class Duwenzhang
      CATEGORIE_BASE_CONFIGS = {
        'aiqingwenzhang' => {
          :name => "爱情文章", :parent => nil,
          :url => "http://www.duwenzhang.com/wenzhang/aiqingwenzhang/list_1_", :page => 61
        },
        'qinqingwenzhang' => {
          :name => "亲情文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/qinqingwenzhang/list_2_", :page => 19
        },
        'youqingwenzhang' => {
          :name => "友情文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/youqingwenzhang/list_3_", :page => 5
        },
        'xiaoyuanwenzhang' => {
          :name => "校园文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/xiaoyuanwenzhang/list_4_", :page => 9
        },
        'jingdianwenzhang' => {
          :name => "经典文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/jingdianwenzhang/list_5_", :page => 10
        },
        'renshengzheli' => {
          :name => "人生哲理", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/renshengzheli/list_6_", :page => 23
        },
        'lizhiwenzhang' => {
          :name => "励志文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/lizhiwenzhang/list_7_", :page => 9
        },
        'shenghuosuibi' => {
          :name => "生活随笔", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/shenghuosuibi/list_8_", :page => 40
        },
        'gaoxiaowenzhang' => {
          :name => "搞笑文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/gaoxiaozhang/list_9_", :page => 18
        },
        'yingyuwenzhang' => {
          :name => "英语文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/yingyuwenzhang/list_10_", :page => 6
        },
        'tuijian' => {
          :name => "推荐文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/tuijian/list_74_", :page => 39
        }       
      }
      
      class << self
        def fetch(options={})
          
        end
        
        def fetch_category(category=nil)          
          cate_config = CATEGORIE_BASE_CONFIGS[category]
          return if cate_config.nil?
          
          cate_config[:page].downto(1) do |i|
#            begin
              unless cate_config[:url].nil?
                base_uri = "#{cate_config[:url]}#{i}.html"
                puts "fetch #{base_uri}"

                doc = March::Fetch::OpenByUri.open(base_uri)

                unless doc.nil?
                  title_fetch2 = doc.css("html body center table.tbspan tr td table tr td table.tbspan tr td b a.ulink")
                  title_fetch2.each do |title|
                    link = title[:href]
                    if !link.blank? && link.include?(".html")
                      puts "#{link}   --------------------------"
#                      begin
                        ArchivesItemFetch.fetch(:from_site => Website::FetchConfig::SITE_DUWENZHANG,
                          :from_uri => link)                      
#                      rescue
#                        next
#                      ensure
#                        next
#                      end
                    end
                  end
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