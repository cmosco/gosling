require 'gosling'

class GooglePage
  include Gosling::Accessors
  
  page_url("http://www.google.com")

  def initialize()
    puts "foo"
  end

end