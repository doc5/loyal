require 'open-uri'
require 'iconv'
require 'sanitize'

class ArchivesItemFetch < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::UuidExtends
  acts_as_huabaner_uuid
  
  include ActsMethods::ActsAsHuabanerModel::VirtueEncodeNode
  acts_as_huabaner_virtue_encode_node
  
  has_and_belongs_to_many :categories, :join_table => "archives_item_fetchs_and_archives_categories", 
    :class_name => "ArchivesCategory", :foreign_key => "item_id",
    :association_foreign_key => "category_id"
  
  validates_uniqueness_of :from_uri, :message =>"已经被占用了"
  
  has_many :avatars, :class_name => "ArchivesAvatar", :as => :resource
  has_one :first_avatar, :class_name => "ArchivesAvatar", :as => :resource, 
    :order => "position ASC"
  
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
      
      fetched_hash = Hash.new
      
      case item_fetch.from_site
      when Website::FetchConfig::SITE_DUWENZHANG
        doc = March::Fetch::OpenByUri.open(item_fetch.from_uri)
        
        fetched_hash[:content] = String.new
        
        p_category_node = doc.css("table .pindao")[1].css("a").last
        fetched_hash[:fetch_category] = p_category_node.text
        
        p_title_node = doc.css("table table tr td h1").first
        fetched_hash[:title] = p_title_node.text
        
        fetched_hash[:content] = doc.css("#wenzhangziti").inner_html
        fetched_hash[:content] = March::StringTools.conv_text(fetched_hash[:content], 'gb2312')
        fetched_hash[:content] = March::StringTools.sanitize(fetched_hash[:content], 'br, p') unless fetched_hash[:content].blank?
              
        item_fetch.fetch_category = fetched_hash[:fetch_category]
        item_fetch.content = fetched_hash[:content]
        item_fetch.title = fetched_hash[:title]
        item_fetch.save
      end    
    end
  end  
end
