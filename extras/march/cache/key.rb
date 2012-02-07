module March
  module Cache
    class Key
      class << self
        def archives_item_fetch_related_items(id, options={})
          "archives_item_fetch_related_items_#{id}_#{format_options(options)}"
        end
        
        def format_options(options={})
          options.values.join("_")
        end
      end
    end
  end
end