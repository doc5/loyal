module RMMSeg
  # A Chunk holds one or more successive Word .
  module Chunk

    # The sum of length of all words.
    def self.total_length(words)
      len = 0
      for word in words
        len += word.length
      end
      len
    end

    # The average length of words.
    def self.average_length(words)
      total_length(words).to_f/words.size
    end

    # The square of the standard deviation of length of all words.
    def self.variance(words)
      avglen = average_length(words)
      sqr_sum = 0.0
      for word in words
        tmp = word.length - avglen
        sqr_sum += tmp*tmp
      end
      Math.sqrt(sqr_sum)
    end

    # The sum of all frequencies of one-character words.
    def self.degree_of_morphemic_freedom(words)
      sum = 0
      for word in words
        if word.length == 1 && word.type == Word::TYPES[:cjk_word]
          sum += word.frequency
        end
      end
      sum
    end
  end
end
