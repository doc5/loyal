# -*- encoding : utf-8 -*-
require "open-uri"

module ActsMethods
  module ActsAsHuabanerModel      
    module AvatarExtends
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::AvatarExtends
      end
      def acts_as_huabaner_avatar(options = {})            
        include ActsMethods::ActsAsHuabanerModel::AvatarExtends::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::AvatarExtends::SingletonMethods  
        
        before_save do |r|
          r.impl_file_download
        end
      end      
      
      module InstanceMethods        
        protected
        
        def impl_file_download
          _local_fullpath = "#{Rails.root}/tmp/tmp_downloads/#{UUIDTools::UUID.random_create.to_s}#{File.extname(URI.parse(self.from_uri).path)}"                
         
          Rails.logger.debug "下载到临时目录:#{_local_fullpath}"
          open(self.from_uri) { |f|                       
            file = File.open("#{_local_fullpath}","wb")            
            file.puts f.read                    
            file.close
          }    
          
          File.open("#{_local_fullpath}", "r") do |f|     
            self.avatar = f
          end
          
          File.delete(_local_fullpath) if File.exists?(_local_fullpath)
        end
      end
      
      module SingletonMethods
        
      end
    end
  end
end