# -*- encoding : utf-8 -*-
class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
