module March
  module Tools
    class WordSeg
      class << self
        def new_ferret_index
          Ferret::Index::Index.new(:analyzer => RMMSeg::Ferret::Analyzer.new)
        end
      end
    end
  end
end