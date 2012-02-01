# -*- ruby -*-

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'rmmseg'

task :default => 'spec:run'

PROJ.name = 'rmmseg'
PROJ.authors = 'pluskid'
PROJ.email = 'pluskid@gmail.com'
PROJ.url = 'http://rmmseg.rubyforge.org'
PROJ.rubyforge_name = 'rmmseg'
PROJ.rdoc_remote_dir = 'rmmseg'
PROJ.version = RMMSeg::VERSION

PROJ.exclude << '\.git'

PROJ.spec_opts << '--color'

# vim: syntax=Ruby
