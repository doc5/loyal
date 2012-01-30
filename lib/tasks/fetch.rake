# rake fetch:book_category_fetch:fetch_360buy RAILS_ENV=development
namespace :fetch do
  namespace :book_category_fetch do
    task :fetch_360buy => :environment do
      puts "--------------start-----------开始抓取京东商城的图书分类-------------------------"
      BookCategoryFetch.fetch_360buy_categories
      puts "--------------end-----------抓取京东商城图书分类完毕-------------------------"
    end     
  end
  
#  rake fetch:archives_item_fetch:duwangzhang:fetch_items RAILS_ENV=development
  namespace :archives_item_fetch do
    namespace :duwangzhang do      
      task :fetch_items => :environment do
        puts "--------------start-----------开始抓取读文章网站的文章-------------------------"
        March::Spider::Duwenzhang.fetch
      puts "--------------end-----------抓取读文章网站的文章-------------------------"
      end
    end
  end
end