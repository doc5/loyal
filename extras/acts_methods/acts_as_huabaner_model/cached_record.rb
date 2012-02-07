## -*- encoding : utf-8 -*-
#module ActsMethods
#  module ActsAsHuabanerModel      
#    module CachedRecord
#      def self.included(base)
#        base.extend ActsMethods::ActsAsHuabanerModel::CachedRecord
#      end
#    
#      def acts_as_huabaner_cached_record(options = {})            
#        include ActsMethods::ActsAsHuabanerModel::CachedRecord::InstanceMethods
#        extend  ActsMethods::ActsAsHuabanerModel::CachedRecord::SingletonMethods  
#        
#        
#      end
#      
#      module InstanceMethods
##        缓存过期
#        def march_cache_expire
#          
#        end
#      end
#
#      module SingletonMethods
#          
#      end  
#    end
#  end
#end
#
#
#ActiveRecord::Base.send(:include, ActsMethods::ActsAsHuabanerModel::CachedRecord)