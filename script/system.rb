$root_path = "#{File.dirname(__FILE__)}/.."
$rails_env = 'production'

def before_running_each
  
end

def after_running_each
  
end

def run_precompile_assets
  system "cd #{$root_path} && rake assets:precompile RAILS_ENV=#{$rails_env}"
end

def run_stop_server
  system "cd #{$root_path} && bundle exec thin stop -C #{$root_path}/config/thin.yml"
end

def run_restart_server
  system "cd #{$root_path} && bundle exec thin restart -C #{$root_path}/config/thin.yml"
end

def run_start_server
#  system "thin config -C #{$root_path}/config/thin.yml --servers 5 -e production -d -p 9000"
  system "cd #{$root_path} && bundle exec thin start -C #{$root_path}/config/thin.yml"
end


COMMANDS_DESC = {
  "a" => ["重启服务器", 'restart_server'],
  "b" => ["开启服务器", 'start_server'],
  "c" => ["停止服务器", 'stop_server'],
  "d" => ["预先生成assets文件", 'precompile_assets']
}

puts "=================请选择任务=================="
COMMANDS_DESC.each do |key, val|
  puts "#{key}:#{val[0]}"
end
puts "    按其他任意键退出 "
puts "==========================================="

def understand(input)
  if COMMANDS_DESC[input]
    puts "开始执行========>:#{COMMANDS_DESC[input][0]}"
    before_running_each
    send("run_#{COMMANDS_DESC[input][1]}")
    after_running_each
    puts "完成========>:#{COMMANDS_DESC[input][0]}"
  else
    puts "放弃操作 退出"
  end  
end

#STDIN.gets
while (input = STDIN.gets.strip).empty?
end
understand input