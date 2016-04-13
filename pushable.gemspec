$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'pushable/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pushable-engine'
  s.version     = Pushable::VERSION
  s.authors     = ['Logan Serman']
  s.email       = ['logan.serman@metova.com']
  s.homepage    = 'https://github.com/lserman/pushable-engine'
  s.summary     = 'Rails engine to manage device tokens and push messaging.'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2'
  s.add_dependency 'activejob', '~> 4.2'
  s.add_dependency 'responders', '~> 2.0'
  s.add_dependency 'mercurius', '0.1.4'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'launchy'

end
