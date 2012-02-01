require 'rmmseg/algorithm'
require 'rmmseg/mm_rule'

module RMMSeg
  class SimpleAlgorithm
    include Algorithm

    # Create a new SimpleAlgorithm . The only rule used by this
    # algorithm is MMRule .
    def initialize(text, token=Token)
      super
    end

    # Get the most proper CJK word.
    def get_cjk_word
      dic = Dictionary.instance
      i = Config.max_word_length
      if i + @index > @chars.length
        i = @chars.length - @index
      end
      chars = @chars[@index, i]
      word = chars.join

      while i > 1 && !dic.has_word?(word)
        i -= 1
        word.slice!(-chars[i].size,chars[i].size) # truncate last char
      end

      token = @token.new(word, @byte_index, @byte_index+word.size)

      @index += i
      @byte_index += word.size

      return token
    end
  end
end
