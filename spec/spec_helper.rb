# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'sections'))

require 'rspec'
require 'selenium-webdriver'
require 'pry'
require 'gosling'

Dir["#{File.dirname(__FILE__)}/pages/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/sections/*.rb"].each { |f| require f }


class RSpec::Core::ExampleGroup
  include Gosling::PageFactory
end

RSpec.configure do |config|
  config.mock_with :mocha
  config.filter_run :focus => true unless ENV.has_key?('BUILD_NUMBER')
  config.run_all_when_everything_filtered = true

  config.before(:all) do
    GC.disable
  end
end

Gosling.short_timeout = 10
Gosling.sections_path = File.join(File.dirname(__FILE__), "sections")
Gosling.flows_path = File.join(File.dirname(__FILE__), "flows")