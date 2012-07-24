require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Browser" do
  
  before(:each) do
    Gosling::Browser.driver
  end
  
  after(:each) do
    Gosling::Browser.reset
  end
  
  it "should create a browser" do
    google_home_page = GooglePage.new()
    google_home_page.go
    google_home_page.search_field.value = "hi"
  end
  
  it "should create a page and update a field" do
    visit_page GooglePage do |p|
      p.search_field.value = "hi"
    end
  end
  
  it "should clear cookies" do
    visit_page GooglePage do |p|
    end
    Gosling::Browser.clear_cookies
  
  end
  
end