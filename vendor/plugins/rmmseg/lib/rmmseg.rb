$KCODE = 'u'
require 'jcode'

require 'rmmseg/config'
require 'rmmseg/simple_algorithm'
require 'rmmseg/complex_algorithm'

module RMMSeg
  VERSION = '0.1.6'
  
  # Segment +text+ using the algorithm configured.
  def segment(text)
    Config.algorithm_instance(text).segment
  end
end
