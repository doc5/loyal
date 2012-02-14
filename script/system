require "find"

$root_path = "#{File.dirname(__FILE__)}/.."
$rails_env = 'production'
$db_backups_path = "#{$root_path}/db/backups"
$db_name = "loyal_production"

def std_gets
  STDIN.gets.strip
end

def current_time_s
  Time.now.strftime("%Y-%m-%d-%H-%M-%S")
end

def scanf_folder_files(path)
  list=[]
  Find.find(path) do |f|
     list << f
  end
  list.sort
end
#===============================================================================
def before_running_each
  
end

def after_running_each
  
end

def run_precompile_assets
  system "cd #{$root_path} && rake assets:precompile RAILS_ENV=#{$rails_env}"
end

def run_stop_server
  system "cd #{$root_path} && bundle exec thin stop -C config/thin.yml"
end

def run_restart_server
  system "cd #{$root_path} && bundle exec thin restart -C config/thin.yml"
end

def run_start_server
#  system "cd #{$root_path} thin config -C config/thin.yml --servers 5 -e production -d -p 9000"
  system "cd #{$root_path} && bundle exec thin start -C config/thin.yml"
end

def run_database_backup
  _sql_full_path = "#{$db_backups_path}/#{current_time_s}.sql"
  system "cd #{$root_path} && mysqldump -uroot -p #{$db_name} > #{_sql_full_path}"
  puts "backup #{$db_name} to:======> #{_sql_full_path}"
end

def run_database_restore
#  _filenames = scanf_folder_files($db_backups_path)
  _filenames = Hash.new
  Dir["#{$db_backups_path}/*.sql"].each_with_index do |name, i|
    _filenames[i.to_s] = File.basename(name)
  end
  _filenames.each do |k, v|
    puts "#{k}:==>#{v}"
  end
  
  if _filenames.any?
    puts "=================请选择要还原的数据库=================="
    _filename = _filenames[std_gets]
    unless _filename.nil?
  #    还原数据库
      _sql_full_path = "#{$db_backups_path}/#{_filename}"
      system "cd #{$root_path} && mysql -uroot -p #{$db_name} < #{_sql_full_path}"
      puts "restore #{_sql_full_path} to:======> #{$db_name}"
    end
  else
    puts "===============没有已经备份的数据库===================="
  end
end

COMMANDS_DESC = {
  "a" => ["重启服务器", 'restart_server'],
  "b" => ["开启服务器", 'start_server'],
  "c" => ["停止服务器", 'stop_server'],
  "d" => ["预先生成assets文件", 'precompile_assets'],
  "e" => ["数据库备份", 'database_backup'],
  "f" => ["数据库还原", 'database_restore']
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