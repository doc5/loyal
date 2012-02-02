require 'rmmseg/rule_helper'

module RMMSeg
  # Maximum matching rule, select the chunks with the
  # maximum length.
  class MMRule
    def self.filter(chunks)
      chunks.take_highest { |a, b|
        Chunk::total_length(a) <=> Chunk::total_length(b)
      }
    end
  end
end
