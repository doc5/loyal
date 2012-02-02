module RMMSeg
  # A Token consists of a term's text and the start and end offset
  # of the term.
  class Token
    # The text of the token
    attr_accessor :text
    
    # The start position of the token. This is *byte* index instead of
    # character.
    attr_accessor :start

    # The one greater than the position of the last byte of the
    # token. This is *byte* index instead of character.
    attr_accessor :end

    # +text+ is the ref to the whole text. In other words:
    # +text[start_pos...end_pos]+ should be the string held by this
    # token.
    def initialize(text, start_pos, end_pos)
      @text = text
      @start = start_pos
      @end = end_pos
    end

    def to_s
      @text.dup
    end
  end
end
