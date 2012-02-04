Loyal::Application.routes.draw do
  get "categories/show"

  get "fetches/show"

  get "home/index"

  constraints :subdomain => "", :domain => 'doc5.com' do
    root :to => "docfive/home#index"
    
  end
  
#  ================================================== yuedu123 start
  constraints :subdomain => "#{SubdomainArchives}", :domain => 'yuedu123.com' do    
    scope :module => "yuedu123", :as => "yuedu123" do
      root :to => "archives/home#index"
      
      scope :module => "archives", :as => "archives" do
        resources :categories, :only => [:index]
        resources :items, :only => [:index]
        resources :fetches, :only => [:index]
        
        match "categories/:url_name", :to => "categories#show", :as => :category
        match "items/:uuid", :to => "items#show", :as => :item
        match "fetches/:uuid", :to => "fetches#show", :as => :fetch
      end
    end
  end
  
  constraints :subdomain => "#{SubdomainWWW}", :domain => /yuedu123.com/ do
    root :to => "yuedu123/home#index"    
    match "search", :to => "yuedu123/home#search", :as => :search    
  end  
# ================================================== yuedu123 end

  
  constraints :subdomain => "#{SubdomainApps}", :domain => 'doc5.com' do
    root :to => "apps/home#index"
    scope :module => "apps", :as => "apps" do
      match "items/reflect/:app_type/:app_flag", :to => "items#reflect", :as => :item_reflect
    end
  end
  
  constraints :subdomain => "#{SubdomainMap}", :domain => 'doc5.com' do
    root :to => "map/home#index"
    scope :module => "map", :as => "map" do
      
    end
  end
  
  constraints :subdomain => "#{SubdomainTip}", :domain => 'doc5.com' do
    root :to => "tip/home#index"
    scope :module => "tip", :as => "tip" do    
      resources :categories, :only => [:show, :index]
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
  constraints :subdomain => "#{SubdomainBook}", :domain => 'doc5.com' do
    scope :module => "book", :as => "book" do
      root :to => "home#index"
    end
  end
  
  constraints :subdomain => "#{SubdomainAdmin}", :domain => 'doc5.com' do      
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
  
  constraints :subdomain => /#{SubdomainWWW}/, :domain => 'doc5.com' do   
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
