require 'open-uri'
require 'iconv'
require 'sanitize'

class BookDetail < ActiveRecord::Base  
  attr_accessor :content_hash
  
  belongs_to :item, :class_name => "BookItem", :foreign_key => "item_id", :counter_cache => true  
  has_and_belongs_to_many :book_category_fetches
  has_one :book_detail_fetch, :foreign_key => :url, :primary_key => :from_uri
  belongs_to :publisher, :counter_cache => true
  has_many :avatars, :class_name => "BookDetailAvatar", :as => :resource
  has_one :first_avatar, :class_name => "BookDetailAvatar", :as => :resource, 
    :order => "position ASC"
  
  validates_presence_of :from_site, :from_uri
  validates_uniqueness_of :from_uri
  
  def after_initialize
    self.impl_content_decode
  end  
  
  before_save do |r|
    r.impl_content_encode 
  end
  
  after_find do |r|
    r.impl_content_decode
  end
  
  CONTENT_OUTLINE         = "outline"
  CONTENT_AUTHOR          = "author"
  CONTENT_EDITOR_COMMENT  = "editor_comemnt"
  CONTENT_CATELOG         = 'catelog'
  CONTENT_NOTE            = 'note'
  CONTENT_MEDIA_COMMENT   = 'media_comment'
  CONTENT_NICE_PICK       = 'nice_pick'
  CONTENT_FOREWORD        = 'foreword'
  
  CONTENT_DESCS = {
    CONTENT_OUTLINE         => "内容提要",
    CONTENT_AUTHOR          => "作者简介",
    CONTENT_EDITOR_COMMENT  => "编辑推荐",
    CONTENT_CATELOG         => '目录',
    CONTENT_NOTE            => '书摘',
    CONTENT_MEDIA_COMMENT   => '媒体评论',
    CONTENT_NICE_PICK       => "精彩书摘",
    CONTENT_FOREWORD        => "前言"
  }
  
#  来源站点名称
  def from_site_name
    site = BookCategoryFetch::CATEGORY_CONFIGS[self.from_site]
    site[:name] unless site.nil?
  end
  
  def first_avatar_url(format=nil)
    self.first_avatar.avatar.url(format) unless self.first_avatar.nil?
  end
  
#  抓取
  def fetch
    unless book_detail_fetch.nil?
      book_detail_fetch.fetch_detail
    end
  end  
  
  def sync_avatars
    case self.from_site
    when Website::BookConfig::SITE_360BUY
#      抓取360buy的图书图片信息
      production_id = "#{self.from_uri.gsub('http://book.360buy.com/', '').gsub('.html', '')}"
      avatar_page_url = "http://www.360buy.com/bigimage.aspx?id=#{production_id}"
      
      uri_open = URI.parse(avatar_page_url)
      result_str = uri_open.read
      doc = Nokogiri::HTML(result_str)
      
      first_image_node = doc.css("html body div.w div.left div.g-0 div#biger img").first
      image_from_uri = first_image_node.attr('src')
      image_alt = first_image_node.attr("alt")
      Rails.logger.debug "Image Path=================>#{image_from_uri}"
      
      book_detail_avatar = BookDetailAvatar.find_by_from_uri(image_from_uri) || 
        BookDetailAvatar.new(:from_uri => image_from_uri)
      book_detail_avatar.alt = image_alt
      book_detail_avatar.resource_type = self.class.to_s
      book_detail_avatar.resource_id   = self.id
      book_detail_avatar.name = self.title
      book_detail_avatar.title = self.title
      book_detail_avatar.save
    end
  end
  
#  同步项目
  def sync_item_by_isbn
    book_item = self.item || BookItem.new
    book_item.isbn = self.isbn
    book_item.isbn_other = self.isbn_other
    book_item.save
    
    self.item_id = book_item.id
    self.save
  end
  
  protected
  
  def impl_content_encode
    self.content_encode = @content_hash.to_yaml
  end
  
  def impl_content_decode
    begin
#      @content_hash = JSON::parse(self.content_encode)
      @content_hash = YAML::load(self.content_encode)
    rescue
      @content_hash = {}
    end
  end
end
