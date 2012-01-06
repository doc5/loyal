# -*- encoding : utf-8 -*-
class Role < ActiveRecord::Base
  
#  https://github.com/ryanb/cancan/wiki/Separate-Role-Model

  
  has_many :assignments
  has_many :users, :through => :assignments  
  
  validates_presence_of :name, :remark
  validates_uniqueness_of :name, :case_sensitive => false
  
  before_save do |r|
    r.name.downcase! unless r.name.nil?
  end
  
  def display_with_remark
    "#{name.humanize}(#{remark})"
  end
end
