# This file integrate RMMSeg with Ferret
require 'singleton'
require 'rubygems'
require 'ferret'
require 'rmmseg'

module RMMSeg
  module Ferret
    # The Analyzer class can be used with Ferret .
    class Analyzer < ::Ferret::Analysis::Analyzer
      
      # Construct an Analyzer. Optional block can be used to
      # add more +TokenFilter+s. e.g.
      #
      #   analyzer = RMMSeg::Ferret::Analyzer.new { |tokenizer|
      #     Ferret::Analysis::LowerCaseFilter.new(tokenizer)
      #   }
      #
      def initialize(&brk)
        @brk = brk
      end
      
      def token_stream(field, text)
        t = PunctuationFilter.new(Tokenizer.new(text))
        if @brk
          @brk.call(t)
        else
          t
        end
      end
    end

    # The Tokenizer tokenize text with RMMSeg::Algorithm.
    class Tokenizer < ::Ferret::Analysis::TokenStream
      # Create a new Tokenizer to tokenize +text+
      def initialize(str)
        self.text = str
      end

      # Get next token
      def next
        @algor.next_token
      end
      
      # Get the text being tokenized
      def text
        @text
      end

      # Set the text to be tokenized
      def text=(str)
        @text = str
        @algor = RMMSeg::Config.algorithm_instance(@text,
                                                   ::Ferret::Analysis::Token)
      end
    end

    # PunctuationFilter filter out the stand alone Chinese
    # punctuation tokens.
    class PunctuationFilter < ::Ferret::Analysis::TokenStream
      # The punctuation dictionary.
      class Dictionary
        include Singleton

        DIC_FILE = File.join(File.dirname(__FILE__),
                             "..",
                             "..",
                             "data",
                             "punctuation.dic")
        def initialize
          @dic = Hash.new
          File.open(DIC_FILE, "r") do |f|
            f.each_line { |line|
              @dic[line.chomp.freeze] = nil
            }
          end
        end

        def include?(str)
          @dic.has_key?(str)
        end
      end
      
      def initialize(stream)
        @stream = stream
      end

      # Get next token, skip stand alone Chinese punctuations.
      def next
        token = @stream.next
        dic = Dictionary.instance

        until token.nil? || !(dic.include? token.text)
          token = @stream.next
        end

        token
      end

      def text
        @stream.text
      end

      def text=(str)
        @stream.text = str
      end
    end
  end
end
