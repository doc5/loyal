module ActsMethods
  module ActsAsHuabanerModel      
    module TreeExtends
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::TreeExtends  
      end
      
      def acts_as_huabaner_tree(options = {})          
        include ActsMethods::ActsAsHuabanerModel::TreeExtends::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::TreeExtends::SingletonMethods
          
        acts_as_nested_set
          
        attr_accessible :name, :parent_id
        attr_protected :lft, :rgt
          
        #          分类自己以及其孩子
        def categories_self_and_children(class_or_item=nil)
          class_or_item = self if class_or_item.nil?
          class_or_item = class_or_item.roots if class_or_item.is_a?(Class)
          items = Array(class_or_item)
          result = []
          items.each do |root|
            result += root.self_and_descendants
          end
          result
        end
          
        #          结构化的所有节点
        def total_tree_struct
          categories_self_and_children
        end
          
        #          根节点
        def root_categories(limit=nil, conditions={})
          find_all_by_parent_id(nil, :order => "position desc", :limit => limit, :conditions => conditions)
        end
          
        #          当前项目从根节点到所有子节点
        def root_and_children(item=nil)
          result = []
          return result if item.nil?
          result = self.categories_self_and_children(item.root)
          result
        end   
          
        #          获取表单中已经选择的分类，用于表单校验出错时候回显
        def current_selected_category(total_array, current_array)
          current_array.each do |c|
            total_array.each do |cc|
              if c.id == cc.id
                return c
              end
            end
          end
          nil
        end

        #          获取表单中已经选择的分类id，用于表单校验出错时候回显
        def current_selected_category_id(total_array, current_array)
          c = current_selected_category(total_array, current_array)
          c.nil? ? nil : c.id
        end
      end
        
      module InstanceMethods          
        def level_with_name
          "#{'- ' * level} #{name}"
        end
                
        def self_and_children
          [self] + self.children
        end
      end
      module SingletonMethods
        #        定义单实例方法

      end
    end
  end
end