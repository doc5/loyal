class ArchivesCategory < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::TreeExtends
  acts_as_huabaner_tree  
  
  has_and_belongs_to_many :item_fetches, :join_table => "archives_item_fetchs_and_archives_categories", 
    :class_name => "ArchivesItemFetch", :foreign_key => "category_id",
    :association_foreign_key => "item_id"
  
  validates_presence_of :url_name, :flag_name
  validates_uniqueness_of :url_name
  validates_uniqueness_of :flag_name
  
  def sql_tree_item_fetches(options={})
    return @_cache_sql_tree_item_fetches if defined?(@_cache_sql_tree_item_fetches)
    _self_and_children_ids = self.self_and_descendants.collect{ |c| c.id }
    
    @_cache_sql_tree_item_fetches = <<SQL
      SELECT `archives_item_fetches`.* FROM `archives_item_fetches` 
      INNER JOIN `archives_item_fetchs_and_archives_categories` ON 
      `archives_item_fetches`.`id` = `archives_item_fetchs_and_archives_categories`.`item_id` 
      WHERE `archives_item_fetchs_and_archives_categories`.`category_id` in (#{_self_and_children_ids.join(',')})      
SQL
    @_cache_sql_tree_item_fetches << "ORDER BY #{options[:order]}" unless options[:order].blank?
    @_cache_sql_tree_item_fetches
  end
  
  def paginate_tree_item_fetches(options={})
    ArchivesItemFetch.paginate_by_sql(self.sql_tree_item_fetches(:order => options[:order]), options)
  end
  
  def tree_item_fetches(options={})
    ArchivesItemFetch.find_by_sql(self.sql_tree_item_fetches, options)
  end
  
  #  刷新所有的计数
  def reset_loyal_counters
    self.self_and_ancestors.each do |cate|
      cate.archives_tree_item_fetches_count = self.tree_item_fetches.count
      cate.archives_item_fetches_count = cate.item_fetches.count
      cate.save
    end
  end
  
#  =====================================> 页面显示逻辑用
  def filter_item_fetches_on_home_box(options={})
    options[:per_page] ||= 15
    self.paginate_tree_item_fetches(:page => 1, :per_page => options[:per_page], :order => "created_at DESC")
  end
#  ====================================================================
  
  class << self
    def increment_item_fetches_counter(id)
      ArchivesCategory.increment_counter(:archives_item_fetches_count, id)
      ArchivesCategory.increment_counter(:archives_tree_item_fetches_count, id)
    end
  
    def decrement_item_fetches_counter(id)
      ArchivesCategory.decrement_counter(:archives_item_fetches_count, id)
      ArchivesCategory.decrement_counter(:archives_tree_item_fetches_count, id)
    end
    
    def reset_loyal_counters
      ArchivesCategory.root_categories.each do |cate|
        cate.reset_loyal_counters
      end
    end
    
    def touch(options={})
      cate = ArchivesCategory.find_by_flag_name(options[:flag_name])
      if cate.nil?
        cate = ArchivesCategory.new options
      end
      cate.save
      cate
    end
  end
  
  
  public
  scope :filter_on_archives_home,
    :conditions => ["flag_name in (?)", 
    [
      'haowen-aiqing', 
      'haowen-qinqing', 
      'haowen-youqing',
      'haowen-shenghuosuibi',
      'haowen-zheli',
      'haowen-lizhi',
      'haowen-jingdian',
      'haowen-gaoxiao',
      'haowen-yingwen',
      'haowen-xiaoyuan'
    ]
  ]
  
end
