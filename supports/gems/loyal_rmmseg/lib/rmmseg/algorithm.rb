require 'jcode'
require 'rmmseg/dictionary'
require 'rmmseg/word'
require 'rmmseg/chunk'
require 'rmmseg/token'

module RMMSeg
  # An algorithm can segment a piece of text into an array of
  # words. This module is the common operations shared by
  # SimpleAlgorithm and ComplexAlgorithm .
  module Algorithm
    # Initialize a new instance of Algorithm, the +text+ will
    # then be segmented by this instance. +token+ is the class
    # which will be used to construct the result token.
    def initialize(text, token=Token)
      @text = text
      @chars = text.each_char
      @index = 0
      @byte_index = 0
      @token = token
    end

    # Get the next Token recognized.
    def next_token
      return nil if @index >= @chars.length

      if basic_latin?(@chars[@index])
        token = get_basic_latin_word
      else
        token = get_cjk_word
      end

      if token.start == token.end # empty
        return next_token
      else
        return token
      end
    end

    # Segment the string in +text+ into an array
    # of words.
    def segment
      words = Array.new

      token = next_token
      until token.nil?
        words << token.text
        token = next_token
      end

      words
    end

    # Skip whitespaces and punctuation to extract a basic latin
    # word.
    def get_basic_latin_word
      start_pos = nil
      end_pos = nil
      
      i = @index
      while i < @chars.length     &&
          basic_latin?(@chars[i]) &&
          nonword_char?(@chars[i])
        i += 1
      end

      start_pos = @byte_index + i - @index
      while i < @chars.length && basic_latin?(@chars[i])
        break if nonword_char?(@chars[i])
        i += 1
      end

      end_pos = @byte_index + i - @index
      while i < @chars.length      &&
          basic_latin?(@chars[i])  &&
          nonword_char?(@chars[i])
        i += 1
      end

      @byte_index += i - @index
      @index = i
      
      return @token.new(@text[start_pos...end_pos], start_pos, end_pos)
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

    # Determine whether a character is a basic latin character.
    def basic_latin?(char)
      char.length == 1
    end

    # Determine whether a character can be part of a basic latin
    # word.
    NONWORD_CHAR_RE = /^\W$/
    def nonword_char?(char)
      NONWORD_CHAR_RE =~ char
    end
  end
end
