require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Browser" do
  it "should create a browser" do
    browser = Gosling::Browser.driver
    google_home_page = GooglePage.new()
    google_home_page.go
    google_home_page.search_field.send_keys("hi")
  end
  
  
  
end