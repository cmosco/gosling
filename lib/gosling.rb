require 'active_support'
require 'gosling/version'
require 'gosling/accessors'
require 'gosling/element'
require 'gosling/browser'
require 'gosling/page_factory'
require 'gosling/configuration'
require 'gosling/flows'
require 'gosling/flow'



module Gosling
  include Accessors
  Gosling.send :extend, Gosling::Configuration
  
  
  def initialize(visit=false)
    #goto if visit && respond_to?(:goto)
    initialize_page if respond_to?(:initialize_page)
  end
  
end