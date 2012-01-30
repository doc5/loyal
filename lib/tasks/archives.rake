# rake archives:item_fetch:spider:fetch_category RAILS_ENV=development site=duwenzhang page=5 down_page=2 category=yingyuwenzhang
# rake archives:item_fetch:spider:duwenzhang:fetch RAILS_ENV=development

namespace :archives do  
  namespace :item_fetch do
    namespace :spider do
      namespace :duwenzhang do
        task :fetch => :environment do
          puts "--------------start-----------抓取duwenzhang网站所有文章-------------------------"
        
          March::Spider::Duwenzhang.fetch
        
          puts "--------------end-----------完成抓取duwenzhang网站所有文章-------------------------"        
        end
      end
      
      task :fetch_category => :environment do
        options = Hash.new
        from_site = ENV['site']
        if from_site.nil?
          puts "site=???  该参数不能为空"
        else
          puts "--------------start-----------开始抓取 #{from_site} 的文章-------------------------"
          options[:category] = ENV['category']
          options[:page] = ENV['page']
          options[:down_page] = ENV['down_page']
        
          case from_site
          when "duwenzhang"
            March::Spider::Duwenzhang.fetch_category(options)
          end        
        
          puts "--------------end-----------完成抓取 #{from_site} 的文章-------------------------"
        end
      end
    end
  end
end