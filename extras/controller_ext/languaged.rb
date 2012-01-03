module ControllerExt
  module Languaged
    def current_lang
      LangConfig::DEFAULT_LANG
    end
    
    def self.included(base)
      base.send :helper_method, :current_lang
    end
  end
end