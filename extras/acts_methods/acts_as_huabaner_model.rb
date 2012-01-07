module ActsMethods
  module ActsAsHuabanerModel
    def self.included(base)
      base.extend TreeExtends  
      base.extend AvatarExtends
      base.extend UUIDExtends
      base.extend OverallVirtueExtends
      base.extend PermissionExtends
    end
      
    module TreeExtends
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
        def root_categories(conditions={}, limit=nil)
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
      
    module AvatarExtends
      #        头像相关
      def acts_as_huabaner_avatar(options = {})          
        include ActsMethods::ActsAsHuabanerModel::AvatarExtends::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::AvatarExtends::SingletonMethods
          
        # 头像相关
        has_attached_file :avatar, :styles => { :medium => "200x200>", :face => "100x100>", :thumb => "50x50>", :show => "700x700>" }, #300x300#是正方形的
        :default_url => "/assets/avatar/miss/:style_#{to_s}.gif",
          :url => "/uploads/images/#{to_s}/:attachment/:id.:style.:extension",
          :path => ":rails_root/public/uploads/images/:class/:attachment/:id_partition/:id_:style.:extension"  

        # validates_attachment_presence :avatar
        validates_attachment_size :avatar, :less_than => 5.megabytes, :message => "图片尺寸不得大于5M"
        validates_attachment_content_type :avatar, :content_type => ['image/gif', 'image/png', 'image/jpeg', 'image/bmp'], 
          :message => "图片类型必须是gif, png, jpg, bmp格式之一"
                            
      end
        
      module InstanceMethods
          
      end
        
      module SingletonMethods
          
      end
    end
      
    module UUIDExtends
      def acts_as_huabaner_uuid(options = {})            
        validates_uniqueness_of :uuid, :message => "必须唯一"
          
        before_create do |r|
          # 随机创建UUID
            
          if r.uuid.nil?
            r.uuid = UUIDTools::UUID.random_create.to_s
          end
        end 
      end
    end
      
    module OverallVirtueExtends        
      def acts_as_overall_virtue(options={})          
        include ActsMethods::ActsAsHuabanerModel::OverallVirtueExtends::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::OverallVirtueExtends::SingletonMethods
      end        
      module InstanceMethods
          
        def virtue(t)
          @result_vitures ||= Hash.new
          return @result_vitures[t][:v] unless @result_vitures[t].nil?
          @result_vitures[t] = {:k => t}
          @result_vitures[t][:v] = OverallVirtue.first :conditions => ["resource_type=? AND resource_id=? AND virtue_type=?", self.class.to_s, id, t]  
        end
      end
        
      module SingletonMethods
          
      end
    end
      
    module PermissionExtends
      def acts_as_huabaner_permission(options={})          
        include ActsMethods::ActsAsHuabanerModel::PermissionExtends::InstanceMethods
        extend  ActsMethods::ActsAsHuabanerModel::PermissionExtends::SingletonMethods
      end        
      module InstanceMethods
          
      end
        
      module SingletonMethods
          
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActsMethods::ActsAsHuabanerModel)