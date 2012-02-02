class Array
  # Take the elements with the highest value. Value are compared
  # through the block. e.g
  #
  #   ["aaaa", "bb", "cccc"].take_highest { |a, b|
  #     a.length <=> b.length
  #   }
  #   # => ["aaaa", "cccc"]
  #
  def take_highest
    return [] if empty?
    
    rlt = [self.first]
    max = self.first

    for i in 1...length
      cmp = yield(self[i], max)
      if cmp == 0
        rlt << self[i]
      elsif cmp > 0
        max = self[i]
        rlt = [max]
      end
    end

    rlt
  end
end
