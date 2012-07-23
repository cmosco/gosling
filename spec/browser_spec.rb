require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Browser do
  it "should create a browser" do
    browser = Browser.driver
    google_home_page = GooglePage.new()
    google_home_page.go
    
  end
end