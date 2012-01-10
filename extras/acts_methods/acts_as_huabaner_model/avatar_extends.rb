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
          
        # 头像相关
        has_attached_file :avatar, :styles => {:thumb => "50x50>", :face => "100x100>", :medium => "200x200>", :show => "700x700>" }, #300x300#是正方形的
        :default_url => "/assets/avatar/miss/:style_#{to_s}.gif",
          :url => "/uploads/images/#{to_s}/:attachment/:id.:style.:extension",
          :path => ":rails_root/public/uploads/images/:class/:attachment/:id_partition/:id_:style.:extension"  

        # validates_attachment_presence :avatar
        validates_attachment_size :avatar, :less_than => 5.megabytes, :message => "图片尺寸不得大于5M"
        validates_attachment_content_type :avatar, :content_type => ['image/gif', 'image/png', 'image/jpeg', 'image/bmp'], 
          :message => "图片类型必须是gif, png, jpg, bmp格式之一"
          
          
        validates_presence_of :from_uri
        validates_uniqueness_of :from_uri          
          
        before_save do |r|
          r.impl_file_download
        end
      end
      
      
      
      module InstanceMethods        
        protected
        
        def impl_file_download
          extend_name = self.from_uri[/\.[^\.]+$/]
          
          self.avatar = open(self.from_uri){|f|
            f.read
          }              
        end
      end
      
      module SingletonMethods
        
      end
    end
  end
end