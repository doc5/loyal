class ArchivesAvatar < ActiveRecord::Base
  def self.table_name
    "base_avatars"
  end
  
  include ActsMethods::ActsAsHuabanerModel::AvatarExtends
  acts_as_huabaner_avatar  
          
  # 头像相关
  has_attached_file :avatar, :styles => {#300x300#是正方形的
    :thumb => "50x50>", 
    :face => "100x100>", 
    :medium => "200x200>",
    :normal => "280x280>",
    :large => "700x700>" 
  }, 
  :default_style => :normal,
  :default_url => "/assets/avatar/miss/:style_#{to_s}.gif",
    :url => "/uploads/images/#{to_s}/:attachment/:id_partition_:style.:extension",
    :path => ":rails_root/public/uploads/images/#{to_s}/:attachment/:id_partition_:style.:extension"
  #          :path => ":rails_root/uploads/images/:class/:attachment/:id_partition/:id_:style.:extension"

  # validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes, :message => "图片尺寸不得大于5M"
  validates_attachment_content_type :avatar, :content_type => ['image/gif', 'image/png', 'image/jpeg', 'image/bmp'], 
    :message => "图片类型必须是gif, png, jpg, bmp格式之一"
  
end
