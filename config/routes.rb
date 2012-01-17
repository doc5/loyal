Loyal::Application.routes.draw do
  
#  root :to => "home#index"
  constraints :subdomain => "#{SubdomainMap}", :domain => 'uusoso.com' do
    root :to => "map/home#index"
    scope :module => "map", :as => "map" do
      
    end
  end

#  root :to => "home#index"

#  =============================================================================
#  blogsoso.com
  constraints :subdomain => "", :domain => 'blogsoso.com' do   
    root :to => "blogsoso/home#index"
    
    scope :module => "blogsoso", :as => "blogsoso" do
      
    end
  end  
#  =============================================================================
  

#  root :to => "home#index"
  constraints :subdomain => "#{SubdomainBook}", :domain => 'uusoso.com' do
    scope :module => "book", :as => "book" do
      root :to => "home#index"
    end
  end
  
  constraints :subdomain => "#{SubdomainAdmin}", :domain => 'uusoso.com' do      
    scope :module => "admin", :as => "admin" do
      root :to => "home#index"
      resources :users
      resources :roles
      
      namespace :overall do
        root :to => "home#index"
        resources :categories do         
        end
      end
      
      namespace :archives do
        root :to => "home#index"
        resources :items do         
        end
      end
      
      namespace :book do
        root :to => "home#index"
        
        resources :categories do 
        
        end
        
        resources :category_fetches, :only => [:index, :show]
        resources :items
        resources :details
        resources :detail_fetches
      end
    end
  end
  
  constraints :subdomain => "", :domain => 'uusoso.com' do   
    root :to => "home#index"
    
    resources :users, :only => [:new, :create] do
      collection  do 
        get "password_edit"
        post "password_update"
      end
    end
    resources :sessions, :only => [:new, :create, :destroy]
    match "login" => "sessions#new", :as => :login
  end
end
