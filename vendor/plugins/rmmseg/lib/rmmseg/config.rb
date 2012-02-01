require 'rmmseg/simple_algorithm'
require 'rmmseg/complex_algorithm'

module RMMSeg
  # Configurations of RMMSeg.
  class Config
    @algorithm = :complex
    @on_ambiguity = :select_first
    data_dir = File.join(File.dirname(__FILE__), "..", "..", "data")
    @dictionaries = [[File.join(data_dir, "chars.dic"), true],
                     [File.join(data_dir, "words.dic"), false]]
    @max_word_length = 4
    
    class << self
      # Get the algorithm name currently using
      def algorithm
        @algorithm
      end
      # Set the algorithm name used to segment. Valid values are
      # +:complex+ and +:simple+ . The former is the default one.
      def algorithm=(algor)
        unless [:complex, :simple].include? algor
          raise ArgumentError, "Unknown algorithm #{algor}"
        end
        @algorithm = algor
      end
      # Get an instance of the algorithm object corresponding to the
      # algorithm name configured. +tok+ is the class of the token oject
      # to be returned. For example, if you want to use with Ferret, you
      # should provide +::Ferret::Analysis::Token+ .
      def algorithm_instance(text, tok=Token)
        RMMSeg.const_get("#{@algorithm}".capitalize+"Algorithm").new(text, tok)
      end

      # Get the behavior description when an unresolved ambiguity occured.
      def on_ambiguity
        @on_ambiguity
      end
      # Set the behavior on an unresolved ambiguity. Valid values are
      # +:raise_exception+ and +:select_first+ . The latter is the default
      # one.
      def on_ambiguity=(behavior)
        unless [:raise_exception, :select_first].include? behavior
          raise ArgumentError, "Unknown behavior on ambiguity: #{behavior}"
        end
        @on_ambiguity = behavior
      end

      # An array of dictionary files. Each element should be of the
      # form: [file, whether_dic_include_frequency_info]. This should
      # be set before the dictionaries are loaded (They are loaded
      # only when they are used). Or else you should call
      # Dictionary.instance.reload manually to reload the
      # dictionaries.
      attr_accessor :dictionaries

      # The maximum length of a CJK word. The default value is 4. Making
      # this value too large might slow down the segment operations.
      attr_accessor :max_word_length
    end
  end
end
