require 'rmmseg/rule_helper'

module RMMSeg
  # Largest sum of degree of morphemic freedom of one-character
  # words rule.
  class LSDMFOCWRule
    def self.filter(chunks)
      chunks.take_highest { |a, b|
        Chunk::degree_of_morphemic_freedom(a) <=> Chunk::degree_of_morphemic_freedom(b)
      }
    end
  end
end
