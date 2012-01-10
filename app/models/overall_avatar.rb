class OverallAvatar < ActiveRecord::Base
  include ActsMethods::ActsAsHuabanerModel::AvatarExtends
  acts_as_huabaner_avatar
end
