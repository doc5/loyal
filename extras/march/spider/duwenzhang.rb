module March
  module Spider
    class Duwenzhang
      CATEGORIE_BASE_URLS = {
        'aiqingwenzhang' => {
          :name => "爱情文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/aiqingwenzhang/", :page => 61,
          :include => ["爱情短信祝福", "感人的爱情故事", "爱情感悟", "爱情格言", "伤感爱情文章", "网络爱情故事", "爱诗"]
        },
        'qinqingwenzhang' => {
          :name => "亲情文章", :parent => nil, 
          :url => "http://www.duwenzhang.com/wenzhang/qinqingwenzhang/", :page => 19
        }        
      }      
    end
  end
end