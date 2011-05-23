# coding: utf-8

$:.push File.expand_path("../lib", __FILE__)
require "capistrano-notification/version"

Gem::Specification.new do |s|
  s.name        = "capistrano-notification"
  s.version     = CapistranoNotification::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Keita Urashima']
  s.email       = ['ursm@ursm.jp']
  s.homepage    = 'http://github.com/ursm/capistrano-notification'
  s.summary     = %q{Capistrano deployment notification}
  s.description = %q{Capistrano deployment notification}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'capistrano'
  s.add_dependency 'validatable'
  s.add_dependency 'shout-bot'

  s.add_development_dependency 'rspec'
end
