# rake archives:item_fetch:fetch_category RAILS_ENV=development site=duwenzhang

namespace :archives do  
  namespace :item_fetch do
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