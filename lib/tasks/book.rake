# => 抓取京东商城的图书分类
# rake book:category_fetch:fetch_360buy RAILS_ENV=development

namespace :book do  
  namespace :category_fetch do
    task :fetch_360buy => :environment do
      puts "--------------start-----------开始抓取京东商城的图书分类-------------------------"
      BookCategoryFetch.fetch_360buy_categories
      puts "--------------end-----------抓取京东商城图书分类完毕-------------------------"
    end   
  end
  
  namespace :item_fetch do
    
  end
end