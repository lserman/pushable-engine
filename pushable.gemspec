$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'pushable/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pushable-engine'
  s.version     = Pushable::VERSION
  s.authors     = ['Logan Serman']
  s.email       = ['logan.serman@metova.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Pushable.'
  s.description = 'TODO: Description of Pushable.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4'
  s.add_dependency 'responders', '~> 2.0'
  s.add_dependency 'mercurius', '>= 0.0.8'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'launchy'

end
