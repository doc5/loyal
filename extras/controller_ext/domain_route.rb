module ControllerExt
  module DomainRoute
    def admin_route(path='', domain=nil)
      subdomain_route(SubdomainAdmin, path, domain)
    end 
    
    def book_route(path='', domain=nil)
      subdomain_route(SubdomainBook, path, domain)
    end
    
    def apps_route(path='', domain=nil)
      subdomain_route(SubdomainApps, path, domain)
    end
    
    def www_route(path='', domain=nil)
      subdomain_route(SubdomainWWW, path, domain)
    end  
    
    def map_route(path='', domain=nil)
      subdomain_route(SubdomainMap, path, domain)
    end  
    
    def tip_route(path='', domain=nil)
      subdomain_route(SubdomainTip, path, domain)
    end        
        
    def feeds_route(path='', domain=nil)
      subdomain_route(SubdomainFeeds, path, domain)
    end
        
    def blank_route(path='', domain=nil)
      "http://#{domain.nil? ? request.domain : domain.strip}#{request.port_string}#{path}"
    end
        
    def subdomain_route(subdomain, path='', domain=nil)
      "http://#{subdomain}.#{domain.nil? ? request.domain : domain.strip}#{request.port_string}#{path}"
    end
  end
end