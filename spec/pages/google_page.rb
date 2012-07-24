require 'gosling'

class GooglePage
  include Gosling::Accessors
  
  page_url("http://www.google.com")
  element(:search_field, :name => "q")
  match_page_title("Google")
  match_page_text("Search")
  match_page_element({:xpath => "//title"}, "Google")
  
end