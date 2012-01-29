# -*- encoding : utf-8 -*-
require "open-uri"

module ActsMethods
  module ActsAsHuabanerModel      
    module ContentEncodeNode
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::ContentEncodeNode
      end
      def acts_as_huabaner_content_encode_node(options = {})            
        include ActsMethods::ActsAsHuabanerModel::ContentEncodeNode::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::ContentEncodeNode::SingletonMethods  
        
        attr_accessor :content_hash
        
  
        def after_initialize
          self.impl_content_decode
        end  
  
        before_save do |r|
          r.impl_content_encode 
        end
  
        after_find do |r|
          r.impl_content_decode
        end        
      end      
      
      module InstanceMethods        
        protected
        
  
        def impl_content_encode
          case self.content_way 
          when "yaml"
            self.content_encode = @content_hash.to_yaml
          end
        end
  
        def impl_content_decode
          begin
            case self.content_way 
            when "yaml"
              @content_hash = YAML::load(self.content_encode)
            end
          rescue
            @content_hash = {}
          end
        end
      end
      
      module SingletonMethods
        
      end
    end
  end
end