require 'iconv'

module March
  class StringTools
    class << self
      def conv_text(text, encoding)
        Iconv.conv('UTF-8//IGNORE', encoding.upcase!, text)
      end
      
      def clean_html(html)
        Sanitize.clean(html)     
      end
    
      #    截断字符串
      def sanitize_truncate_u(html, length = 30, truncate_string = "...")
        text = Sanitize.clean(html)
        truncate_u(text, length, truncate_string)
      end
    
      def truncate_u(text, length = 30, truncate_string = "...")
        l = 0
        char_array = text.unpack("U*")
        char_array.each_with_index do |c,i|
          l = l + (c < 127 ? 0.5 : 1)
          if l >= length
            return char_array[0..i].pack("U*") + (i < char_array.length - 1 ? truncate_string : "")
          end
        end
        return text
      end    
    
      def sanitize(html, ok_tags='a href, b, br, i, p' )
        # no closing tag necessary for these
        solo_tags = ["br", "hr"]
    
        # Build hash of allowed tags with allowed attributes
        tags = ok_tags.downcase().split(',').collect!{ |s| s.split(' ') }
        allowed = Hash.new
        tags.each do |s|
          key = s.shift
          allowed[key] = s
        end
    
        # Analyze all <> elements
        stack = Array.new
        result = html.gsub( /(<.*?>)/m ) do | element |
          if element =~ /\A<\/(\w+)/ then
            # </tag>
            tag = $1.downcase
            if allowed.include?(tag) && stack.include?(tag) then
              # If allowed and on the stack
              # Then pop down the stack
              top = stack.pop
              out = "</#{top}>"
              until top == tag do
                top = stack.pop
                out << "</#{top}>"
              end
              out
            end
          elsif element =~ /\A<(\w+)\s*\/>/
            # <tag />
            tag = $1.downcase
            if allowed.include?(tag) then
              "<#{tag} />"
            end
          elsif element =~ /\A<(\w+)/ then
            # <tag ...>
            tag = $1.downcase
            if allowed.include?(tag) then
              if ! solo_tags.include?(tag) then
                stack.push(tag)
              end
              if allowed[tag].length == 0 then
                # no allowed attributes
                "<#{tag}>"
              else
                # allowed attributes?
                out = "<#{tag}"
                while ( $' =~ /(\w+)=("[^"]+")/ )
                  attr = $1.downcase
                  valu = $2
                  if allowed[tag].include?(attr) then
                    out << " #{attr}=#{valu}"
                  end
                end
                out << ">"
              end
            end
          end
        end
      
        # eat up unmatched leading >
        while result.sub!(/\A([^<]*)>/m) { $1 } do end
      
        # eat up unmatched trailing <
        while result.sub!(/<([^>]*)\Z/m) { $1 } do end
      
        # clean up the stack
        if stack.length > 0 then
          result << "</#{stack.reverse.join('></')}>"
        end
    
        result
      end
    end
  end
end