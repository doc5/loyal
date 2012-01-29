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
    
      item_fetch = ArchivesItemFetch.find_by_from_uri(options[:from_uri]) || ArchivesItemFetch.new(
        :from_site => options[:from_site],
        :from_uri => options[:from_uri]
      )
    
      uri_open = URI.parse(item_fetch.from_uri)
      result_str = uri_open.read      
      doc = Nokogiri::HTML(result_str)
      
      #      defined fetch
      fetched_hash = Hash.new
      
      case item_fetch.from_site
      when Website::FetchConfig::SITE_DUWENZHANG        
        fetched_hash[:content] = String.new
        
        p_title_node = doc.css("table table tr td h1").first
        fetched_hash[:title] = p_title_node.text
        
        p_content_nodes = doc.css("#wenzhangziti>p")        
        p_content_nodes.each do |node|
          node_text = node.text.strip
          Rails.logger.debug "===>#{node_text}"
          fetched_hash[:content] << "<p>#{node_text}</p>"
        end
      
        item_fetch.content = fetched_hash[:content]
        item_fetch.title = fetched_hash[:title]
        item_fetch.save
      end    
    end
  end  
end
