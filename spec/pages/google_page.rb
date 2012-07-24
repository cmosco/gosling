require 'gosling'

class GooglePage
  include Gosling::Accessors
  
  page_url("http://www.google.com")
  element(:search_field, :name => "q")
  element_via_xpath(:page_title_element_from_xpath, "//title")  
  match_page_title("Google")
  match_page_text("Search")
  match_page_element({:xpath => "//title"}, "Google")
  
end