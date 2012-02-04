# -*- encoding : utf-8 -*-
require 'rmmseg'
require 'rmmseg/ferret'

module ActsMethods
  module ActsAsHuabanerModel      
    module SeggableWord
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::SeggableWord
      end
    
      def acts_as_huabaner_seggable_word(options = {})            
        include ActsMethods::ActsAsHuabanerModel::SeggableWord::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::SeggableWord::SingletonMethods  
        
        has_many :hot_words, :class_name => "SegHotWord", :as => :seggable, :order => "freq DESC"
        
        after_save do |r|
          
        end
      end
      
      module InstanceMethods
#        relation
# => 相关项目
        def related_items(limit=10)
          if defined?(self.related_item_ids_list) && self.related_item_ids_list
            _results = self.class.find :all, :conditions => ["id in (?)", self.related_item_ids_list.split(",")], :limit => limit
          else
            _results = self.catulate_related_item_ids(limit)
          end          
          _results
        end
        
        def catulate_related_item_ids(limit=10)
          seg_string = "#{self.shared_searcher_title} #{self.shared_searcher_categories} #{self.rec_tag_list}"
          segs = RMMSeg::SimpleAlgorithm.new(seg_string).segment
          _results = ActsAsFerret.find(segs.join("||"), 'shared', :page => 1, :per_page => limit * 2 + 1)
          _results.delete_at(0)
          
          if defined?(self.related_item_ids_list)
            self.related_item_ids_list = _results.collect{|c| c.id}.join(",")
            self.save
          end
          _results[0, limit]
        end
        
        #        计算热词
        # => 首先，计算出记录中频率最高的前20个词语（该词语需要在辞典中存在）
        def calculate_hot_words(limit=20)
          seg_string = "#{self.shared_searcher_title} #{self.shared_searcher_content}"
          segs = RMMSeg::SimpleAlgorithm.new(seg_string).segment
          _segs_hashed = Hash.new
          _seg_ids_array = Array.new
          
          Rails.logger.debug "================> 读取热词"
          
          _seg_words = (SegWord.find :all, :conditions => ['name in (?)', segs]).uniq
          
          Rails.logger.debug "================> 读取热词完毕"
          
          segs.each do |seg|
            seg.downcase!
            #            TODO: || => &&
            if SegWord.could_seg?(seg)
              seg_word = (_seg_words.select{|s| s.name == seg }).first || SegWord.create(:name => seg)
              if !seg_word.blocked? && seg_word.seggable                
                if _segs_hashed[seg]
                  _segs_hashed[seg][:freq] += 1
                else                  
                  _seg_ids_array << seg_word.id
                  _segs_hashed[seg] = {:id => seg_word.id, :freq => 0}
                end                
              end
            end
          end    
          
          Rails.logger.debug "================> _hot_segs = (_segs_hashed...."
          
          _hot_segs = (_segs_hashed.sort{|a1, a2| a2[1][:freq] <=> a1[1][:freq]})[0, limit]
          
          _rm_hot_word_ids = Array.new
          (self.class.find(self.id).hot_words.collect{|h| h.seg_word_id }).each do |hid|
            _rm_hot_word_ids << hid unless _seg_ids_array.include?(hid)
          end
          
          Rails.logger.debug "================> 删除废弃的SegHotWord"
          
          if _rm_hot_word_ids.any?
            SegHotWord.destroy_all ["seggable_type=? AND seggable_id=? AND seg_word_id in(?)", 
              self.class.name, self.id, _rm_hot_word_ids]
          end
          
          Rails.logger.debug "================> 新建SegHotWord"
          
          #TODO:          ?需要优化算法          
          _hot_segs.each do |word, seg_word|            
            SegHotWord.create(
              :seg_word_id => seg_word[:id], 
              :freq => seg_word[:freq],
              :seggable_type => self.class.name,
              :seggable_id => self.id
            )
          end
        end          
      end

      module SingletonMethods
          
      end  
    end
  end
end