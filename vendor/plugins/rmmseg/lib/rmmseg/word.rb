module RMMSeg
  # An object representing a CJK word.
  class Word
    TYPES = {
      :unrecognized => :unrecognized,
      :basic_latin_word => :basic_latin_word,
      :cjk_word => :cjk_word
    }.freeze

    # The content text of the word.
    attr_reader :text

    # The type of the word, may be one of the key of TYPES .
    attr_reader :type

    # The frequency of the word. This value is meaningful only
    # when this is a one-character word.
    attr_reader :frequency

    # Initialize a Word object.
    def initialize(text, type=TYPES[:unrecognized], frequency=nil)
      @text = text
      @type = type
      @frequency = frequency
      @length = @text.jlength
    end

    # The number of characters in the word. *Not* number of bytes.
    def length
      @length
    end

    # The number of bytes in the word.
    def byte_size
      @text.length
    end
  end
end
