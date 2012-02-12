module ActsMethods
  module ActsAsHuabanerModel      
    module UuidExtends
      def self.included(base)
        base.extend ActsMethods::ActsAsHuabanerModel::UuidExtends        
      end
      def acts_as_huabaner_uuid(options = {})        
#        validates_presence_of :uuid    
        validates_uniqueness_of :uuid, :message => "必须唯一"
          
        before_save do |r|
          # 随机创建UUID          
          r.uuid = UUIDTools::UUID.random_create.to_s if r.uuid.nil?
        end 
      end
    end
  end
end