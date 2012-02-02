Gem::Specification.new do |s|
  s.name = 'loyal_rmmseg'
  s.version = '0.0.2'

  # s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['happy']
  s.date = '2012-02-02'
  s.description = 'Chinese Seg.'
  s.email = 'happy@doc5.com'
  s.files = Dir['README.txt', 'History.txt', 'Manifest.txt', 'Rakefile', 'lib/**/*', 'data/**/*', 'bin/**/*', 'misc/**/*', 'spec/**/*', 'tasks/**/*']
  s.homepage = 'http://www.doc5.com'
  s.licenses = ["MIT"]
#  s.require_path = 'lib'
#  s.require_paths = ['bin', 'data', 'lib', 'misc', 'spec', 'tasks']
  s.rubygems_version = '1.3.7'
  s.summary = 'Nice Chinese Seg.'

  s.add_runtime_dependency('rake', [">= 0"])
end

=begin

version = File.read(File.expand_path("../../RAILS_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'activerecord'
  s.version = version
  s.summary = 'Object-relational mapper framework (part of Rails).'
  s.description = 'Databases on Rails. Build a persistent domain model by mapping database tables to Ruby classes. Strong conventions for associations, validations, aggregations, migrations, and testing come baked-in.'

  s.required_ruby_version = '>= 1.9.3'

  s.author = 'David Heinemeier Hansson'
  s.email = 'david@loudthinking.com'
  s.homepage = 'http://www.rubyonrails.org'

  s.files = Dir['CHANGELOG.md', 'MIT-LICENSE', 'README.rdoc', 'examples/**/*', 'lib/**/*']
  s.require_path = 'lib'

  s.extra_rdoc_files = %w( README.rdoc )
  s.rdoc_options.concat ['--main', 'README.rdoc']

  s.add_dependency('activesupport', version)
  s.add_dependency('activemodel', version)
  s.add_dependency('arel', '~> 3.0.0.rc1')
  s.add_dependency('tzinfo', '~> 0.3.29')
end

=end
