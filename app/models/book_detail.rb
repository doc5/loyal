class BookDetail < ActiveRecord::Base  
  attr_accessor :content_hash
  
  belongs_to :item, :class_name => "BookItem", :foreign_key => "item_id", :counter_cache => true  
  has_and_belongs_to_many :book_category_fetches
  has_one :book_detail_fetch, :foreign_key => :url, :primary_key => :from_uri
  belongs_to :publisher, :counter_cache => true
  
  validates_presence_of :from_site, :from_uri
  validates_uniqueness_of :from_uri
  
  def after_initialize
    self.impl_content_decode
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
  
  def fetch
    unless book_detail_fetch.nil?
      book_detail_fetch.fetch_detail
    end
  end
  
  before_save do |r|
    r.impl_content_encode 
  end
  
  after_find do |r|
    r.impl_content_decode
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
