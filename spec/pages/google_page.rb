require 'gosling'

class GooglePage
  include Gosling::Accessors
  
  page_url("http://www.google.com")
  element(:search_field, :name => "q")

end