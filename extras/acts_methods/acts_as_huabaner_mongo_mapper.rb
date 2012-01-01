module ActsMethods
  module ActsAsHuabanerMongoMapper
    module Tree
      def self.included(base)
        base.extend TreeExtends  
      end
      
      module TreeExtends  
        def acts_as_huabaner_mongo_mapper_tree(options = {})           
          plugin MongoMapper::Plugins::ActsAsTree      
          acts_as_tree
          include ActsMethods::ActsAsHuabanerMongoMapper::Tree::TreeExtends::InstanceMethods
          extend  ActsMethods::ActsAsHuabanerMongoMapper::Tree::TreeExtends::SingletonMethods

          #          自己以及其孩子
          def tree_self_and_children(class_or_item=nil)
            class_or_item = self if class_or_item.nil?
            class_or_item = class_or_item.roots if class_or_item.is_a?(Class)
            items = Array(class_or_item)
            result = Array.new
            items.each do |root|
              result += root.self_and_descendants
            end
            result
          end
          
        end
        
        module InstanceMethods
          def self_and_descendants
            [self] + self.descendants
          end
          
          def self_and_ancestors
            ancestors << self
          end
          
          def leveled_name(field=nil)
            "#{'- ' * depth}#{field||name}"
          end
        end

        module SingletonMethods

        end
      end
    end
  end
end