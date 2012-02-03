class SegWord < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  STATUS_INIT  = 0
  
  class << self
    def sync_rmmseg_words
      if defined? RMMSeg
        RMMSeg::Config.dictionaries.each { |file, has_freq|
          if has_freq
            load_rmmseg_dictionary_with_freq(file)
          else
            load_rmmseg_dictionary(file)
          end
        }
      end
    end
    
    def could_seg?(w)
      w.u.length > 1
    end
  end
  
  private
  
  
  class << self
    def load_rmmseg_dictionary_with_freq(file)
      _records = Array.new
      
      File.open(file, "r") { |f|
        f.each_line { |line|
          pair = line.split(" ")
          seg_word = SegWord.find_by_name(pair[0])
          if seg_word.nil?
            _records << {:name => pair[0], :status => STATUS_INIT, 
              :freq => pair[1], :blocked => false, :seggable => SegWord.could_seg?(pair[0])}
#            seg_word = SegWord.new(:name => pair[0], :status => STATUS_INIT, :freq => pair[1])
#            seg_word.save
          end
        }
      }
      
      SegWord.create(_records)
    end
    def load_rmmseg_dictionary(file)
      _records = Array.new
      File.open(file, "r") { |f|
        f.each_line { |line|
          line.slice!(-1)       # chop!
          seg_word = SegWord.find_by_name(line)

          if seg_word.nil?
            _records << {:name => line, :status => STATUS_INIT, 
              :freq => 0, :blocked => false, :seggable => SegWord.could_seg?(line)}
#            seg_word = SegWord.new(:name => line, :status => STATUS_INIT)
#            seg_word.save
          end
        }
      }
      
      SegWord.create(_records)
    end
  end
end
