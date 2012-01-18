namespace :fetch do
  task :book_category_fetches_do => :environment do
    case ENV['site']
    when '360buy'
      BookCategoryFetch.fetch_360buy_categories
    end
  end
end