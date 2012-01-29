require 'iconv'

module March
  class StringTools
    class << self
      def conv_text(text, encoding)
        Iconv.conv('UTF-8//IGNORE', encoding.upcase!, text)
      end
    end
  end
end