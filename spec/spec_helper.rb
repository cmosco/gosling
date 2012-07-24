# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))


require 'rspec'
require 'selenium-webdriver'
require 'pry'
require 'gosling'

Dir["#{File.dirname(__FILE__)}/pages/*.rb"].each { |f| require f }

class RSpec::Core::ExampleGroup
  include Gosling::PageFactory
end
