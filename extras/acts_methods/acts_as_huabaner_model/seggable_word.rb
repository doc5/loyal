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
        
        has_many :hot_words, :class_name => "SegHotWord", 
          :as => :seggable, :order => "freq DESC"
        
        after_save do |r|
          
        end
      end
      
      module InstanceMethods
#        计算热词
# => 首先，计算出记录中频率最高的前20个词语（该词语需要在辞典中存在）
        def calculate_hot_words(limit=20)
          seg_string = "#{self.shared_searcher_title} #{self.shared_searcher_content}"
          segs = RMMSeg::SimpleAlgorithm.new(seg_string).segment
          _segs_hashed = Hash.new
          segs.each do |seg|
            seg.downcase!
#            TODO: || => &&
            if SegWord.could_seg?(seg)
              seg_word = SegWord.find_by_name(seg) || SegWord.create(:name => seg)
              
              if !seg_word.blocked? && seg_word.segable
                if _segs_hashed[seg]
                  _segs_hashed[seg][:freq] += 1
                else
                  _segs_hashed[seg] = {:id => seg_word.id, :freq => 0}
                end                
              end
            end
          end          
          
          _hot_segs = (_segs_hashed.sort{|a1, a2| a2[1][:freq] <=> a1[1][:freq]})[0, limit]
          
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