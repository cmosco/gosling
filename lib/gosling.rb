require 'active_support'
require 'gosling/version'
require 'gosling/accessors'
require 'gosling/page'
require 'gosling/element'
require 'gosling/browser'
require 'gosling/page_factory'


module Gosling
  include Accessors
    
  def initialize(visit=false)
    #goto if visit && respond_to?(:goto)
    initialize_page if respond_to?(:initialize_page)
  end
  
    
end