namespace :homepage do
  desc 'generate homepage'
  task :generate do
    sh "cd misc && gerbil html homepage.erb > homepage.html"
  end

  desc 'publish homepage to rubyforge'
  task :publish => :generate do
    remote_path = "rubyforge.org:/var/www/gforge-projects"
    sh "scp misc/homepage.html #{remote_path}/rmmseg/index.html"
  end
end
