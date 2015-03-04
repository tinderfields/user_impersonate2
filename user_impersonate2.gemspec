$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tinderfields_user_impersonate/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'tinderfields_user_impersonate'
  s.version     = TinderfieldsUserImpersonate::VERSION
  s.authors = ['Richard Cook', 'Dr Nic Williams', 'Many people at Engine Yard']
  s.email = 'rcook@rcook.org'
  s.homepage = 'https://github.com/rcook/user_impersonate2'
  s.summary     = "Allow staff users to pretend to be your customers"
  s.description = "Allow staff users to pretend to be your customers; to impersonate their account."
  s.license = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-cucumber"
  s.add_development_dependency "launchy"
end

