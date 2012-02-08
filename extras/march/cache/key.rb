module March
  module Cache
    class Key
      class << self
        def yuedu123_archives_item_fetch_related_items(id, options={})
          "yuedu123_archives_item_fetch_related_items_#{id}_#{format_options(options)}"
        end
        
        def yuedu123_archives_home_main_panel_boxes(options={})
          "yuedu123_archives_home_main_panel_boxes_#{format_options(options)}"
        end
        
        def yuedu123_layout_header(options={})
        "yuedu123_layout_header_#{format_options(options)}"
        end
        
        def yuedu123_layout_search_tab(options={})
          "yuedu123_layout_search_tab_#{format_options(options)}"
        end
        
        def yuedu123_archives_category_path(category, options={})
          "yuedu123_archives_category_path_#{category.id if category.present?}_#{format_options(options)}"
        end
        
        def format_options(options={})
          options.values.join("_")
        end
      end
    end
  end
end