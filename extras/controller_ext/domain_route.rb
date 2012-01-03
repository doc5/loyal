module ControllerExt
  module DomainRoute
    def admin_route(path='')
      subdomain_route(SubdomainAdmin, path)
    end 
    
    def book_route(path='')
      subdomain_route(SubdomainBook, path)
    end 
    
    def www_route(path='')
      subdomain_route(SubdomainWWW, path)
    end        
        
    def feeds_route(path='')
      subdomain_route(SubdomainFeeds, path)
    end
        
    def blank_route(path='')
      "http://#{request.domain}#{request.port_string}#{path}"
    end
        
    def subdomain_route(subdomain, path='')
      "http://#{subdomain}.#{request.domain}#{request.port_string}#{path}"
    end
  end
end