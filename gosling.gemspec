require './lib/gosling/version'

Gem::Specification.new do |s|
  s.name        = "gosling"
  s.version     = Gosling::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Moscardini"]
  s.email       = ["chris_moscardini@gmail.com"]
  s.homepage    = "http://github.com/cmoscardini/gosling"
  s.summary     = "A simple page object model DSL for webdriver"
  s.description = "A simple page object model DSL for webdriver"
  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
  s.add_dependency('selenium-webdriver', '>= 2.25.0')
  s.add_dependency('rspec', '>= 2.0.0')
end