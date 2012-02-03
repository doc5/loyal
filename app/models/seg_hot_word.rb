class SegHotWord < ActiveRecord::Base
  validates_uniqueness_of :seg_word_id, :scope => [:seg_word_id, :seggable_type, :seggable_id]
  
  class << self
    
  end
end
