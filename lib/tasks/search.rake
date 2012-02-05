# rake search:aaf:rebuild RAILS_ENV=development
namespace :search do
  namespace :aaf do
    task :rebuild => :environment do
      puts "--------------start-----------重建索引-------------------------"
      ActsAsFerret::rebuild_index 'shared'
      puts "--------------end-----------重建索引-------------------------"
    end     
  end
end