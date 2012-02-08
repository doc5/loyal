# -*- encoding : utf-8 -*-
require "open-uri"

module ActsMethods
  module ActsAsHuabanerModel      
    module VirtueEncodeNode
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::VirtueEncodeNode
      end
      def acts_as_huabaner_virtue_encode_node(options = {})            
        include ActsMethods::ActsAsHuabanerModel::VirtueEncodeNode::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::VirtueEncodeNode::SingletonMethods  
        
        attr_accessor :virtue_hash
        
  
        def after_initialize
          self.impl_virtue_decode
        end
  
        before_save do |r|
          r.impl_virtue_encode 
        end
  
        after_find do |r|
          r.impl_virtue_decode
        end        
      end      
      
      module InstanceMethods        
        protected
        
  
        def impl_virtue_encode
          case self.virtue_way 
          when "yaml"
            self.virtue_encode = @virtue_hash.to_yaml
          end
        end
  
        def impl_virtue_decode
          begin
            case self.virtue_way 
            when "yaml"
              @virtue_hash = YAML::load(self.virtue_encode)
            end
          rescue
            @virtue_hash = {}
          end
        end
      end
      
      module SingletonMethods
        
      end
    end
  end
end