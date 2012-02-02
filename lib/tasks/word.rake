# rake word:seg_word:sync_rmmseg_words RAILS_ENV=development
namespace :word do
  namespace :seg_word do
    task :sync_rmmseg_words => :environment do
      puts "--------------start-----------开始同步RMMSeg中字典-------------------------"
      SegWord.sync_rmmseg_words
      puts "--------------end-----------开始同步RMMSeg中完毕-------------------------"
    end
  end
end