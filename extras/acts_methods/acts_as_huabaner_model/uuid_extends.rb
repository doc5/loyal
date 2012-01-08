module ActsMethods
  module ActsAsHuabanerModel      
    module UuidExtends
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::UuidExtends
      end
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
  end
end