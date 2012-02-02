$KCODE = 'u'
require 'jcode'

require 'rmmseg/config'
require 'rmmseg/simple_algorithm'
require 'rmmseg/complex_algorithm'

module RMMSeg
  VERSION = File.read(File.expand_path("../../VERSION", __FILE__)).strip
  
  # Segment +text+ using the algorithm configured.
  def segment(text)
    Config.algorithm_instance(text).segment
  end
end
