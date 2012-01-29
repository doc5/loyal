Loyal::Application.routes.draw do
  constraints :subdomain => "", :domain => 'doc5.com' do
    root :to => "docfive/home#index"
    
  end
  
  constraints :subdomain => "#{SubdomainApps}", :domain => 'doc5.com' do
    root :to => "apps/home#index"
    scope :module => "apps", :as => "apps" do
      match "items/reflect/:app_type/:app_flag", :to => "items#reflect", :as => :item_reflect
    end
  end
  
  constraints :subdomain => "#{SubdomainMap}", :domain => 'uusoso.com' do
    root :to => "map/home#index"
    scope :module => "map", :as => "map" do
      
    end
  end
  
  constraints :subdomain => "#{SubdomainTip}", :domain => 'uusoso.com' do
    root :to => "tip/home#index"
    scope :module => "tip", :as => "tip" do    
      resources :categories            
      resources :posts, :only => [:show, :new, :destroy, :edit, :update, :create]
      resources :comments          
      
      #      match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
      #      match 'categories/:url_name' => 'categories#show', :as => :category
      #      match 'categories' => 'categories#index', :as => :categores        
      #      resources :posts
    end
  end

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
      
      namespace :tip do
        root :to => "home#index"
        resources :categories do       
        end              
        resources :posts
      end
      
      namespace :archives do
        root :to => "home#index"
        resources :categories
        resources :items
        resources :item_fetches
      end
      
      namespace :book do
        root :to => "home#index"
        
        resources :categories do 
          
        end
        
        resources :category_fetches, :only => [:index, :show] do
          member do
            post 'operate'
          end
        end
        resources :items
        resources :details
        resources :detail_fetches, :only => [:index, :show, :edit] do
          collection do 
            post 'operate'
          end
        end
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
