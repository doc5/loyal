module MongoModel
  class FetchChannel
    include MongoMapper::Document
      
    key :minutes_interval, Integer, :default => 10
      
    key :status_open, Boolean, :default => true
    key :fetch_open, Boolean, :default => true
    key :referral_open, Boolean, :default => false
    key :catelog_open, Boolean, :default => false  #分类页面显示
      
    key :retry_count, Integer, :default => 0
    key :try_count, Integer, :default => 0
    key :fetch_count, Integer, :default => 0
    key :position, Integer, :default => 0
    
    key :xpath, String
    key :type_fetch, Integer, :default => TYPE_FETCH_DEFAULT
      
    key :uri, String
    key :name, String
    key :introduction, String
    key :publish_date, Date
      
    key :link, String
    key :title, String
    key :description, String
      
    key :category, String
    key :clound, String
    key :copyright, String
    key :docs, String
    key :generator, String
    key :image, String
    key :language, String
    key :last_build_date, Date
    key :managing_editor, String
    key :rating, String
    key :skip_days, String
    key :skip_hours, String
    key :text_input, String
    key :ttl, String
    key :web_master, String
      
    key :image_title, String
    key :image_link, String
    key :image_url, String
      
    timestamps!
    
    belongs_to :fetch_catelog, :class_name => "MongoModel::FetchCatelog"
    many :fetch_items, :class_name => "MongoModel::FetchItem"
    
    def do_fetch!
      rss_spider = March::Fetch::RssSpider.new(:uri => self.uri)
      if rss_spider.save
        feed = rss_spider.feed        
        
        self.link        = feed.channel.link
        self.description = feed.channel.description
        self.title       = feed.channel.title
      
        self.category        = feed.channel.category
        self.copyright       = feed.channel.copyright
        self.docs            = feed.channel.docs
        self.generator       = feed.channel.generator
        self.image           = feed.channel.image
        self.language        = feed.channel.language
        self.last_build_date   = feed.channel.lastBuildDate
        self.managing_editor  = feed.channel.managingEditor
        self.publish_date         = feed.channel.pubDate
        self.rating          = feed.channel.rating
        self.skip_days        = feed.channel.skipDays
        self.skip_hours       = feed.channel.skipHours
        self.text_input       = feed.channel.textInput
        self.ttl             = feed.channel.ttl
        self.web_master       = feed.channel.webMaster
          
        self.image_title     = "#{feed.channel.image.title unless feed.channel.image.nil?}"
        self.image_link      = "#{feed.channel.image.link unless feed.channel.image.nil?}"
        self.image_url       = "#{feed.channel.image.url unless feed.channel.image.nil?}"
          
        self.save!
        
        MongoModel::FetchItem.feed_items(self, feed.channel.items)
      end
    end
  end
end


#RSS <channel> 参考手册
#元素 	描述
#<category> 	可选的。为 feed 定义所属的一个或多个种类。
#<cloud> 	可选的。注册进程，以获得 feed 更新的立即通知。
#<copyright> 	可选。告知版权资料。
#<description> 	必需的。描述频道。
#<docs> 	可选的。规定指向当前 RSS 文件所用格式说明的 URL。
#<generator> 	可选的。指定用于生成 feed 的程序。
#<image> 	可选的。在聚合器呈现某个 feed 时，显示一个图像。
#<language> 	可选的。规定编写 feed 所用的语言。
#<lastBuildDate> 	可选的。定义 feed 内容的最后修改日期。
#<link> 	必需的。定义指向频道的超链接。
#<managingEditor> 	可选的。定义 feed 内容编辑的电子邮件地址。
#<pubDate> 	可选的。为 feed 的内容定义最后发布日期。
#<rating> 	可选的。feed 的 PICS 级别。
#<skipDays> 	可选的。规定忽略 feed 更新的天。
#<skipHours> 	可选的。规定忽略 feed 更新的小时。
#<textInput> 	可选的。规定应当与 feed 一同显示的文本输入域。
#<title> 	必需的。定义频道的标题。
#<ttl> 	可选的。指定从 feed 源更新此 feed 之前，feed 可被缓存的分钟数。
#<webMaster> 	可选的。定义此 feed 的 web 管理员的电子邮件地址。