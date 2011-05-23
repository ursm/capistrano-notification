require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'capistrano-notification'
    gem.summary = %Q{Capistrano deployment notification}
    gem.description = %Q{Capistrano deployment notification}
    gem.email = 'ursm@ursm.jp'
    gem.homepage = 'http://github.com/ursm/capistrano-notification'
    gem.authors = ['Keita Urashima']

    gem.add_dependency 'capistrano'
    gem.add_dependency 'validatable'
    gem.add_dependency 'shout-bot'

    gem.add_development_dependency 'rspec', '>= 1.2.9'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "capistrano-notification #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
