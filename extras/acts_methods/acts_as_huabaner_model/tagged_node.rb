# -*- encoding : utf-8 -*-

module ActsMethods
  module ActsAsHuabanerModel      
    module TaggedNode
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::AvatarExtends
      end
      def acts_as_huabaner_tagged(options = {})            
        include ActsMethods::ActsAsHuabanerModel::TaggedNode::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::TaggedNode::SingletonMethods  
        

      end      
      
      module InstanceMethods        
        protected
        
      end
      
      module SingletonMethods
        
      end
    end
  end
end