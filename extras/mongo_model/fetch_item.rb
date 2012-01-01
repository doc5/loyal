module MongoModel
  class FetchItem    
    include MongoMapper::Document
    
    key :status_open, Boolean, :default => true
    #      是否被推荐？？
    key :referral_open, Boolean, :default => true
      
    key :retry_count, Integer, :default => 0
    key :fetch_count, Integer, :default => 0
    key :view_count,  Integer, :default => 0
    key :down_count,  Integer, :default => 0
    key :up_count,    Integer, :default => 0
    key :hot_count, Integer, :default => 0
    
    key :content_fetch, String     
    key :content_fetched, Boolean, :default => false 
    key :page_full,   String
    key :type_fetch, Integer, :default => TYPE_FETCH_DEFAULT
    
    key :publish_date, Time
      
    key :guid, String
      
    key :title, String
    key :author, String
    key :category, String
    key :fetch_comments, String
    key :description, String
    key :enclosure, String
    key :link, String
    key :source, String
      
    timestamps!
    
    scope :referred, :order => "hot_count desc", :referral_open => true, :status_open => true
      
    belongs_to :rss_channel, :class_name => "MongoModel::FetchChannel"
    
    def self.feed_items(channel, items)
      items.each do |item|
        puts "item------#{item.link} - #{channel.id}"
          
        guid = "#{item.link unless item.link.blank?}"
        itm = MongoModel::FetchItem.find_by_guid(guid) || 
          MongoModel::FetchItem.new(:guid => guid, :link => item.link)
          
        itm.rss_channel_id = channel.id
        itm.guid = guid
        itm.title = item.title
        itm.link = item.link
        itm.description = item.description
        itm.category = item.category
        itm.author = item.author
        itm.publish_date = item.pubDate
        itm.source = item.source
        itm.enclosure = item.enclosure
          
        itm.save           
      end
    end
  end
end


#RSS <item> 参考手册
#元素 	描述
#<author> 	可选的。规定项目作者的电子邮件地址。
#<category> 	可选的。定义项目所属的一个或多个类别。
#<comments> 	可选的。允许项目连接到有关此项目的注释（文件）。
#<description> 	必需的。描述此项目。
#<enclosure> 	可选的。允许将一个媒体文件导入一个项中。
#<guid> 	可选的。为项目定义一个唯一的标识符。
#<link> 	必需的。定义指向此项目的超链接。
#<pubDate> 	可选的。定义此项目的最后发布日期。
#<source> 	可选的。为此项目指定一个第三方来源。
#<title> 	必需的。定义此项目的标题。
