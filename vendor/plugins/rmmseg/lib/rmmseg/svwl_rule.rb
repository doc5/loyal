require 'rmmseg/rule_helper'

module RMMSeg
  # Smallest variance of word length rule.
  class SVWLRule
    def self.filter(chunks)
      chunks.take_highest { |a, b|
        Chunk::variance(b) <=> Chunk::variance(a)
      }
    end
  end
end
