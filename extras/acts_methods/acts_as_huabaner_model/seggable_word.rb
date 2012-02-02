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
          :as => :seggable, :order => "count DESC", :limit => 20
        
        after_save do |r|
          
        end
      end
      
      module InstanceMethods      
#        计算热词
# => 首先，计算出记录中频率最高的前20个词语（该词语需要在辞典中存在）
        def calculate_hot_words
          seg_string = "#{self.shared_searcher_title} #{self.shared_searcher_content}"
          seg_index = Ferret::Index::Index.new(:analyzer => RMMSeg::Ferret::Analyzer.new)
#          seg_index << seg_string
          segs = RMMSeg::SimpleAlgorithm.new(seg_string).segment
#          segs
        end          
      end

      module SingletonMethods
          
      end  
    end
  end
end