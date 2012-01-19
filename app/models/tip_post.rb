class TipPost < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::UuidExtends
  acts_as_huabaner_uuid
  
  
  belongs_to :category, :class_name => "TipCategory"
  
#  validates_presence_of :category, :message => "请选择分类"
  validate do |r|
    r.errors.add :category, "请选择分类" if r.tip_category_id.blank? || (TipCategory.find_by_id(r.tip_category_id).nil?)
  end
  
  validates_presence_of :title, :message => "请填写标题"
  validates_presence_of :content, :message => "请填写正文"
end
