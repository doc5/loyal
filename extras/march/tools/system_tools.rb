# -*- encoding : utf-8 -*-
module March
  module Tools
    module SystemTools
      def memory_look
        process_status = File.open("/proc/#{Process.pid}/status")  
        13.times { process_status.gets }  
        rss_before_action = process_status.gets.split[1].to_i  
        process_status.close  
        
        res = nil
        if block_given?
          res = yield
        end
          
        process_status = File.open("/proc/#{Process.pid}/status")  
        13.times { process_status.gets }  
        rss_after_action = process_status.gets.split[1].to_i  
        process_status.close 

        Rails.logger.error "==============> CONSUME MEMORY: #{rss_after_action - rss_before_action} \KB\tNow: #{rss_after_action} KB"
        res
      end
    end
  end
end