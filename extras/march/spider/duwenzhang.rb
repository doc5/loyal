# call: 
#   March::Spider::Duwenzhang.fetch 抓取所有读文章网站的文章

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
          :url => "http://www.duwenzhang.com/wenzhang/gaoxiaowenzhang/list_9_", :page => 18
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
      
      CATEGORIES_FETCH_MAP = {    
        "爱情文章" => "aiqing", "爱情短信祝福" => 'aiqingduanxin', "感人的爱情故事" => 'aiqingganren',
        "爱情感悟" => "aiqingganwu", "爱情格言" => "aiqinggeyan", "伤感爱情文章" => "aiqingshanggan",
        "网络爱情故事" => "aiqingwangluo", "qq空间爱情文章" => "aiqing", "爱诗" => "aiqingshige",  
        "亲情文章" => "qinqing", 	"感悟亲情" => 'qinqingganwu', "亲情短信" => "qinqingduanxin",
        "亲情格言" => "qinqinggeyan", "友情文章" => "youqing", "友情短信" => "youqingduanxin", "友谊名言" => "youqingmingyan",  
        "生活随笔" => "shenghuosuibi","成长文章" => 'suibichengzhang', "个性文章" => "suibigexing", "生活感悟" => "shenghuoganwu",
        "生活趣事" => "shenghuoqushi", 
        "校园文章" => "xiaoyuan", "大学生活文章" => "xiaoyuandaxue", "校园爱情文章" => "xiaoyuanaiqing", "校园趣事" => "xiaoyuanqushi",
        "中学校园文章" => "xiaoyuanzhongxue",  
        "经典文章" => "jingdian", "经典情感文章" => 'jingdianqinggan',  "经典寓言故事" => "jingdianyuyan",  
        "人生哲理" => "zheli", "人生感悟" => "renshengganwu", "爱情哲理" => "zheliaiqing", "成功哲理" => "zhelichenggong",
        "人生格言" => "renshenggeyan", "关于生命" => "guanyushengming",  
        "励志文章" => "lizhi",	"励志故事" => "lizhigushi", "励志格言" => "lizhigeyan", "励志短信" => "lizhiduanxin",
        "搞笑文章" => "gaoxiao",	"幽默笑话" => "gaoxiaoyoumo", "搞笑故事" => "gaoxiaogushi", "短信笑话" => "gaoxiaoduanxin",
        "儿童笑话" => "gaoxiaoertong", "搞笑短信" => "gaoxiaoduanxin", "经典笑话" => "gaoxiaojingdian",  
        "心情日记" => "rijixinqing",	
        "英语文章" => "yingwen",	"书虫英文小说" => "yingwenxiaoshuo",  "英文爱情文章" => "yingwenaiqing",
        "英文寓言故事" => "yingwenyuyan", "英文哲理故事" => "yingwenzheli", "英语谚语" => "yingyuyanyu",  
        "原创文章" => "yuanchuang",	
        "原创诗歌" => "yuanchuangshige",	"抒情诗" => "yuanchuanshuqingshi", "叙事诗" => "yuanchuangxushishi",  
        "文章推荐" => "tuijian"	
      }
      
      ROOT_FLAG_NAME = 'haowen'
      PREFIX_FLAG_NAME = "#{ROOT_FLAG_NAME}-"
      
      INIT_CATEGORIES = [
        ['aiqing', {:name => '爱情文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['qinqing', {:name => '亲情文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['youqing', {:name => '友情文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['shenghuosuibi', {:name => '生活随笔', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['xiaoyuan', {:name => '校园文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['jingdian', {:name => '经典文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['zheli', {:name => '哲理文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['lizhi', {:name => '励志文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['gaoxiao', {:name => '搞笑文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['yingwen', {:name => '英语文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['riji', {:name => '日记', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['yuanchuang', {:name => '原创文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        ['tuijian', {:name => '推荐文章', :pflag => "#{ROOT_FLAG_NAME}"}],
        
        ['aiqingzhufu', {:name => '爱情祝福', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],
        ['aiqingganren', {:name => '感人爱情', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],
        ['aiqingganwu', {:name => '爱情感悟', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],
        ['aiqinggeyan', {:name => '爱情格言', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],
        ['aiqingshanggan', {:name => '伤感爱情', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],
        ['aiqingwangluo', {:name => '网络爱情', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],
        ['aiqingduanxin', {:name => '爱情短信', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],
        ['aiqingshige', {:name => '爱情诗歌', :pflag => "#{PREFIX_FLAG_NAME}aiqing"}],            
        
        ['qinqingganwu', {:name => '感悟亲情', :pflag => "#{PREFIX_FLAG_NAME}qinqing"}],
        ['qinqingduanxin', {:name => '亲情短信', :pflag => "#{PREFIX_FLAG_NAME}qinqing"}],
        ['qinqinggeyan', {:name => '亲情格言', :pflag => "#{PREFIX_FLAG_NAME}qinqing"}],
                
        ['youqingduanxin', {:name => '友情短信', :pflag => "#{PREFIX_FLAG_NAME}youqing"}],
        ['youqingmingyan', {:name => '友谊名言', :pflag => "#{PREFIX_FLAG_NAME}youqing"}],        
        
        ['suibichengzhang', {:name => '成长文章', :pflag => "#{PREFIX_FLAG_NAME}shenghuosuibi"}],
        ['suibigexing', {:name => '个性文章', :pflag => "#{PREFIX_FLAG_NAME}shenghuosuibi"}],
        ['shenghuoganwu', {:name => '生活感悟', :pflag => "#{PREFIX_FLAG_NAME}shenghuosuibi"}],
        ['shenghuoqushi', {:name => '生活趣事', :pflag => "#{PREFIX_FLAG_NAME}shenghuosuibi"}],
        
        ['xiaoyuandaxue', {:name => '大学生活', :pflag => "#{PREFIX_FLAG_NAME}xiaoyuan"}],
        ['xiaoyuanaiqing', {:name => '校园爱情', :pflag => "#{PREFIX_FLAG_NAME}xiaoyuan"}],
        ['xiaoyuanqushi', {:name => '校园趣事', :pflag => "#{PREFIX_FLAG_NAME}xiaoyuan"}],
        ['xiaoyuanzhongxue', {:name => '中学校园', :pflag => "#{PREFIX_FLAG_NAME}xiaoyuan"}],
                
        ['jingdianqinggan', {:name => '经典情感文章', :pflag => "#{PREFIX_FLAG_NAME}jingdian"}],
        ['jingdianyuyan', {:name => '经典寓言故事', :pflag => "#{PREFIX_FLAG_NAME}jingdian"}],
        
        ['renshengganwu', {:name => '人生感悟', :pflag => "#{PREFIX_FLAG_NAME}zheli"}],
        ['zheliaiqing', {:name => '爱情哲理', :pflag => "#{PREFIX_FLAG_NAME}zheli"}],
        ['zhelichenggong', {:name => '成功哲理', :pflag => "#{PREFIX_FLAG_NAME}zheli"}],
        ['renshenggeyan', {:name => '人生格言', :pflag => "#{PREFIX_FLAG_NAME}zheli"}],
        ['guanyushengming', {:name => '关于生命', :pflag => "#{PREFIX_FLAG_NAME}zheli"}],
        
        ['lizhigushi', {:name => '励志故事', :pflag => "#{PREFIX_FLAG_NAME}lizhi"}],
        ['lizhigeyan', {:name => '励志格言', :pflag => "#{PREFIX_FLAG_NAME}lizhi"}],
        ['lizhiduanxin', {:name => '励志短信', :pflag => "#{PREFIX_FLAG_NAME}lizhi"}],
        
        ['gaoxiaoyoumo', {:name => '幽默笑话', :pflag => "#{PREFIX_FLAG_NAME}gaoxiao"}],
        ['gaoxiaogushi', {:name => '搞笑故事', :pflag => "#{PREFIX_FLAG_NAME}gaoxiao"}],
        ['gaoxiaoduanxin', {:name => '短信笑话', :pflag => "#{PREFIX_FLAG_NAME}gaoxiao"}],
        ['gaoxiaoertong', {:name => '儿童笑话', :pflag => "#{PREFIX_FLAG_NAME}gaoxiao"}],
        ['gaoxiaojingdian', {:name => '经典笑话', :pflag => "#{PREFIX_FLAG_NAME}gaoxiao"}],        
        
        ['yingwenxiaoshuo', {:name => '英文小说', :pflag => "#{PREFIX_FLAG_NAME}yingwen"}],
        ['yingwenaiqing', {:name => '英文爱情', :pflag => "#{PREFIX_FLAG_NAME}yingwen"}],
        ['yingwenyanyu', {:name => '英文寓言', :pflag => "#{PREFIX_FLAG_NAME}yingwen"}],
        ['yingwenzheli', {:name => '英文哲理', :pflag => "#{PREFIX_FLAG_NAME}yingwen"}],
        ['yingwenyanyu', {:name => '英语谚语', :pflag => "#{PREFIX_FLAG_NAME}yingwen"}],
      ]
      
      class << self
# => March::Spider::Duwenzhang.init_categories
        def init_categories
          ArchivesCategory.touch(:flag_name => "#{ROOT_FLAG_NAME}", :name => "好文章", :url_name => "haowen")
          INIT_CATEGORIES.each do |flag_name, opt|
            flag_name = "#{PREFIX_FLAG_NAME}#{flag_name}"
            pcate = ArchivesCategory.find_by_flag_name("#{opt[:pflag]}")
            unless pcate.nil?
              ArchivesCategory.touch(:flag_name => "#{flag_name}", 
                :name => "#{opt[:name]}", 
                :url_name => "#{flag_name}", 
                :parent_id => pcate.id
              )
            end
          end
        end
        
        def classify_categories_map
          return @_cache_classify_categories_map if defined?@_cache_classify_categories_map
          _categories = ArchivesCategory.find :all, :conditions => ["flag_name in (?)", CATEGORIES_FETCH_MAP.values.collect{|v| "#{PREFIX_FLAG_NAME}#{v}" }]
          @_cache_classify_categories_map = Hash.new
          _categories.each do |cate|
            @_cache_classify_categories_map[cate.flag_name] = cate
          end
          @_cache_classify_categories_map
        end
        
        def classify_category(item)
          _category = self.classify_categories_map["#{PREFIX_FLAG_NAME}#{CATEGORIES_FETCH_MAP[item.fetch_category]}"]
          if _category.present? && !item.category_ids.include?(_category.id)
            Rails.logger.debug "归类==========> #{_category.name} 更新"
            item.categories << _category
            item.save
          else
            Rails.logger.debug "==========> category 无更新"
          end
        end
        
#        归类所有的文章
# => March::Spider::Duwenzhang.classify_categories
        def classify_categories(options={})          
          ArchivesItemFetch.find_all_by_from_site(Website::FetchConfig::SITE_DUWENZHANG).each do |item|
            self.classify_category(item)
          end
          true
        end
        
#        抓取
        def fetch(options={})
          CATEGORIE_BASE_CONFIGS.keys.each do |cate|
            self.fetch_category(:category => cate, :force_update => false)
          end
        end
        
#        抓取分类
        def fetch_category(options={})          
          cate_config = CATEGORIE_BASE_CONFIGS[options[:category]]
          return if cate_config.nil?
          
          (options[:page] || cate_config[:page]).to_i.downto((options[:down_page] || 1).to_i) do |i|
            begin
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
                      begin
                        ArchivesItemFetch.fetch(:from_site => Website::FetchConfig::SITE_DUWENZHANG,
                          :from_uri => link, :force_update => options[:force_update])                      
                      rescue
                        next
                      ensure
                        next
                      end
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