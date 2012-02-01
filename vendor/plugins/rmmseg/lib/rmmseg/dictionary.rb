require 'singleton'

module RMMSeg
  # The dictionary is a singleton object which is lazily initialized.
  # *NOTE* dictionary data should use the UNIX line-break '\n' instead
  # of DOS '\r\n'.
  class Dictionary
    include Singleton

    # Initialize and load dictionaries from files specified by
    # +Config.dictionaries+ .
    def initialize
      load_dictionaries
    end

    # Determin whether +value+ is a word in the dictionary.
    def has_word?(value)
      @dic.has_key?(value)
    end

    # Store a new word to dictionary.
    # +w+ may be:
    # * an instance of Word.
    # * +true+, then this is a normal world.
    # * a String(which can be converted to a Number) or Number.
    #   The number is the frequency of the word.
    def store_word(key, w=true)
      @dic[key] = w
    end

    # Get an instance of Word corresponding to +value+ .
    def get_word(value)
      word = @dic[value]
      # Construct a Word lazily
      if word == true
        word = Word.new(value.dup, Word::TYPES[:cjk_word])
        @dic[value] = word
      elsif String === word
        word = Word.new(value.dup, Word::TYPES[:cjk_word], word.to_i)
        @dic[value] = word
      end
      word
    end

    # Reload all dictionary files.
    def reload
      @dic = nil
      load_dictionaries
    end

    private
    def load_dictionaries
      @dic = Hash.new
      Config.dictionaries.each { |file, has_freq|
        if has_freq
          load_dictionary_with_freq(file)
        else
          load_dictionary(file)
        end
      }
    end

    def load_dictionary_with_freq(file)
      File.open(file, "r") { |f|
        f.each_line { |line|
          pair = line.split(" ")
          @dic[pair[0]] = pair[1]
        }
      }
    end
    def load_dictionary(file)
      File.open(file, "r") { |f|
        f.each_line { |line|
          line.slice!(-1)       # chop!
          @dic[line] = true
        }
      }
    end
  end
end
