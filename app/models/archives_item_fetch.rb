require 'open-uri'
require 'iconv'
require 'sanitize'

class ArchivesItemFetch < ActiveRecord::Base
#  acts_as_huabaner_cached_record
  
  include ActsMethods::ActsAsHuabanerModel::UuidExtends
  acts_as_huabaner_uuid
  
  include ActsMethods::ActsAsHuabanerModel::VirtueEncodeNode
  acts_as_huabaner_virtue_encode_node
  
  include ActsMethods::ActsAsHuabanerModel::SeggableWord
  acts_as_huabaner_seggable_word
  
  has_and_belongs_to_many :categories, :join_table => "archives_item_fetchs_and_archives_categories", 
    :class_name => "ArchivesCategory", :foreign_key => "item_id",
    :association_foreign_key => "category_id"
  
  has_many :avatars, :class_name => "ArchivesAvatar", :as => :resource
  has_one :first_avatar, :class_name => "ArchivesAvatar", :as => :resource, 
    :order => "position ASC"
  
  validates_presence_of :title
  validates_uniqueness_of :from_uri, :message =>"已经被占用了"
  
#  取值==================================
  def first_category
    self.categories.first
  end
#  ==================================
  
#  操作===================================================================
# => 抓取文章
  def fetch
    fetched_hash = Hash.new
    
    case self.from_site
    when Website::FetchConfig::SITE_DUWENZHANG
      doc = March::Fetch::OpenByUri.open(self.from_uri)
        
      fetched_hash[:content] = String.new
      
      p_author_node = doc.css("table .author a")[0]
      fetched_hash[:author] = p_author_node.text
        
      p_category_node = doc.css("table .pindao")[0].css("a").last
      fetched_hash[:fetch_category] = p_category_node.text
        
      p_title_node = doc.css("table table tr td h1").first
      fetched_hash[:title] = p_title_node.text
        
      fetched_hash[:content] = doc.css("#wenzhangziti").inner_html
      fetched_hash[:content] = March::StringTools.conv_text(fetched_hash[:content], 'gb2312')
      fetched_hash[:content] = March::StringTools.sanitize(fetched_hash[:content], 'br, p') unless fetched_hash[:content].blank?
              
      self.fetch_category = fetched_hash[:fetch_category]
      self.content = fetched_hash[:content]
      self.title = fetched_hash[:title]
      self.fetch_author = fetched_hash[:author]
      self.save
    end  
  end
#  ======================================================================
  
  class << self
    def fetch(options={})
      #    TODO: from_site include?
      return if options[:from_site].nil?
    
      item_fetch = ArchivesItemFetch.find_by_from_uri(options[:from_uri])
      if item_fetch.nil?
        item_fetch = ArchivesItemFetch.new(
          :from_site => options[:from_site],
          :from_uri => options[:from_uri]
        )
      else
        return unless options[:force_update]
      end
        
      item_fetch.fetch
    end
  end
  
#  for search attrs
  def shared_searcher_categories
    self.categories.collect{|c| c.name}.join(",")
  end
  
  def shared_searcher_created_by
    
  end
  
  def shared_searcher_title
    self.title
  end
  
  def shared_searcher_outline(limit=110)
    @_cahce_shared_searcher_outline_hash = Hash.new if @_cahce_shared_searcher_outline_hash.nil?
    @_cahce_shared_searcher_outline_hash[limit] ||= March::StringTools.truncate_u(shared_searcher_content, limit)    
  end
  
  def shared_searcher_content
    @_cache_shared_searcher_content ||= March::StringTools.clean_html(self.content)
  end
  
  def shared_searcher_created_at
    self.created_at.to_s
  end
  def shared_searcher_updated_at
    self.updated_at.to_s
  end
end
