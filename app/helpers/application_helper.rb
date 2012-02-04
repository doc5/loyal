module ApplicationHelper
  include ControllerExt::DomainRoute
  
  def helper_ferret_result_linker(result, options={})
    options[:highlight] ||= false
    options[:query_words] ||= ""
    options[:target] ||= "_blank"
    _highlight_class = options[:highlight] ? " class='highlight'" : ""
    if result.is_a?(ArchivesItemFetch)
      link_to raw(result.highlight(options[:query_words], :field => :title, 
              :pre_tag => "<span#{_highlight_class}>", :post_tag => "</span>")), 
            archives_route(yuedu123_archives_fetch_path(:uuid => result.uuid)), 
            :target => options[:target]
    else
      raw result.highlight(options[:query_words], :field => :title, :pre_tag => "<span#{_highlight_class}'>", :post_tag => "</span>")
    end
  end
end
