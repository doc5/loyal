require 'open-uri'
require 'iconv'
require 'sanitize'

class ArchivesItemFetch < ActiveRecord::Base
  #  acts_as_huabaner_cached_record
  attr_accessor :ferret_enabled
  def after_initialize
    self.ferret_enabled = false
  end
  
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
  
  validates_presence_of :title, :content
  validates_uniqueness_of :from_uri, :message =>"已经被占用了"
  
  #  取值==================================
  def display_pubtime
    if self.fetch_pubtime.present?
      self.fetch_pubtime
    else 
      self.created_at.strftime("%Y-%m-%d %H:%M:%S")
    end 
  end
  
  def first_category
    self.categories.first
  end
  
  def nearby_related_items(options={})    
    options[:per_page] ||= 10
    options[:compare_opts] ||= 1
    options[:page] ||= 1
    case options[:compare_opts]
    when 1
      _compare_conditions = "archives_item_fetches.id > #{self.id}"
      _order_conditions = "id ASC"
    when -1
      _compare_conditions = "archives_item_fetches.id < #{self.id}"
      _order_conditions = "id DESC"
    end
    options[:ids] ||= self.categories.collect{|cate| cate.id}
    options[:offset] ||= ((options[:page] - 1) * options[:per_page])
    
    _sql = <<SQL
      SELECT `archives_item_fetches`.* FROM `archives_item_fetches` 
      INNER JOIN `archives_item_fetchs_and_archives_categories` ON 
      `archives_item_fetches`.`id` = `archives_item_fetchs_and_archives_categories`.`item_id` 
      WHERE `archives_item_fetchs_and_archives_categories`.`category_id` in (#{options[:ids]})
      AND #{_compare_conditions}
      ORDER BY #{_order_conditions}
      LIMIT #{options[:per_page]} OFFSET #{options[:offset]}
SQL
    ArchivesItemFetch.find_by_sql(_sql)
  end
  
  def related_items(options={:limit => 10})
    []
  end
  
  def next_related_item
    nearby_related_items(:compare_opts => 1).first
  end
  
  def pre_related_item
    nearby_related_items(:compare_opts => -1).first
  end
  
  
  
  #  def related_items(limit=20)
  #    
  #  end
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
      
    when Website::FetchConfig::SITE_SINA
      doc = March::Fetch::OpenByUri.open(self.from_uri)
      fetched_hash[:content] = String.new
      fetched_hash[:fetch_images] = String.new
      
      doc.css("#artibody p").each do |p|
        _p_text = March::StringTools.clean_html(p.content)
        fetched_hash[:content] << "<p>#{_p_text}</p>" unless _p_text.start_with?("\n\n.icon_sina, .icon_msn, .icon_fx{ background-position")
      end
      
      _categories = Array.new
      doc.css("#lo_links a").each do |a|
        _categories << a.text
      end
      
      doc.css("#artibody .img_wrapper").each do |img|
        _img = img.css("img").first
        fetched_hash[:fetch_images] << "<img alt=\"#{_img.attr('alt')}\" title=\"#{_img.attr('title')}\" src=\"#{_img.attr('src')}\"></img>"
      end
      
      fetched_hash[:fetch_category] = _categories.join(";")      
      fetched_hash[:title] = doc.css("#artibodyTitle").text
      fetched_hash[:author] = doc.css("#media_name").text
      fetched_hash[:pubtime] = doc.css("#pub_date").text
      
      Rails.logger.debug "pubtime:#{fetched_hash[:pubtime]}||title:#{fetched_hash[:title]}||content:#{fetched_hash[:content]}||"
      
      self.fetch_category = fetched_hash[:fetch_category]
      self.content = fetched_hash[:content]
      self.fetch_images = fetched_hash[:fetch_images]
      self.title = fetched_hash[:title]
      self.fetch_pubtime = fetched_hash[:pubtime]
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
  def ferret_enabled?
    self.ferret_enabled
  end
  
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
