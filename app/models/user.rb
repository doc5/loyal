class User < ActiveRecord::Base
  
  
  #=> 角色相关
  # in models/user.rb
  def role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  def super_admin?
    id == 1
  end
  def admin?
    super_admin? || role?(:admin)
  end
  def roles_to_s
    result = ""
    for role in roles
      result << "#{role.display_with_remark};"
    end
    result
  end
end
