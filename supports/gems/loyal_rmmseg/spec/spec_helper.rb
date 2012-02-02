$: << File.join(File.dirname(__FILE__), "../lib")
require 'rmmseg'

def gen_words words, freqs=nil
  if freqs.nil?
    words.map { |word| RMMSeg::Word.new(word) }
  else
    words.zip(freqs).map { |word, freq|
      RMMSeg::Word.new(word, RMMSeg::Word::TYPES[:cjk_word], freq)
    }
  end
end
