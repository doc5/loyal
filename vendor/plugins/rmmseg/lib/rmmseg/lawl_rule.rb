require 'rmmseg/rule_helper'

module RMMSeg
  # Largest average word length rule.
  class LAWLRule
    def self.filter(chunks)
      chunks.take_highest { |a, b|
        Chunk::average_length(a) <=> Chunk::average_length(b)
      }
    end
  end
end
