require 'rmmseg/algorithm'
require 'rmmseg/mm_rule'
require 'rmmseg/lawl_rule'
require 'rmmseg/svwl_rule'
require 'rmmseg/lsdmfocw_rule'

module RMMSeg
  class ComplexAlgorithm
    MATCH_CACHE_MAX_LENGTH = 3

    include Algorithm

    # Create a new ComplexAlgorithm . Rules used by this algorithm
    # includes MMRule , LAWLRule , SVWLRule and LSDMFOCWRule .
    def initialize(text, token=Token)
      super
      @rules = [
                MMRule,
                LAWLRule,
                SVWLRule,
                LSDMFOCWRule
               ]
      @match_cache = Array.new(MATCH_CACHE_MAX_LENGTH)
      @match_cache_idx = 0
    end

    # Get the most proper CJK word.
    def get_cjk_word
      chunks = create_chunks
      i = 0
      while i < @rules.length
        break if chunks.length < 2
        chunks = @rules[i].filter(chunks)
        i += 1
      end

      if chunks.length > 1
        if Config.on_ambiguity == :raise_exception
          raise Ambiguity, "Can't solve ambiguity on #{chunks}"
        end
      end

      word = chunks[0][0]
      token = @token.new(word.text, @byte_index, @byte_index+word.byte_size)
      
      @index += word.length
      @byte_index += word.byte_size

      return token
    end

    # Create all possible three-word (or less) chunks
    # starting from +@index+ .
    def create_chunks
      chunks = Array.new
      for w0 in find_match_words(@index)
        index0 = @index + w0.length
        if index0 < @chars.length
          for w1 in find_match_words(index0)
            index1 = index0 + w1.length
            if index1 < @chars.length
              for w2 in find_match_words(index1)
                if w2.type == Word::TYPES[:unrecognized]
                  chunks << [w0, w1]
                else
                  chunks << [w0, w1, w2]
                end
              end
            elsif index1 == @chars.length
              chunks << [w0, w1]
            end
          end
        elsif index0 == @chars.length
          chunks << [w0]
        end
      end

      chunks
    end

    # Find all words occuring in the dictionary starting from
    # +index+ . The maximum word length is determined by
    # +Config.max_word_length+ .
    def find_match_words(index)
      for i, w in @match_cache
        if i == index
          return w
        end
      end
      
      dic = Dictionary.instance
      str = String.new
      strlen = 0
      words = Array.new
      i = index

      while i < @chars.length               &&
          !basic_latin?(@chars[i])          &&
          strlen < Config.max_word_length
        
        str << @chars[i]
        strlen += 1
        
        if dic.has_word?(str)
          words << dic.get_word(str)
        end
        i += 1
      end

      if words.empty?
        words << Word.new(@chars[index], Word::TYPES[:unrecognized])
      end

      @match_cache[@match_cache_idx] = [index, words]
      @match_cache_idx += 1
      @match_cache_idx = 0 if @match_cache_idx == MATCH_CACHE_MAX_LENGTH

      words
    end

  end
end
