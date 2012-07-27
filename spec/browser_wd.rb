require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Browser" do
  before(:all) do
    Gosling::Browser.driver
    Gosling.short_timeout = 10
  end
  
  after(:each) do
    Gosling::Browser.reset
  end
  
  it "should include the google header section" do
    google_home_page = GooglePage.new
    google_home_page.go
    google_home_page.image_link.click
  end
  
  it "should create a browser" do
    google_home_page = GooglePage.new
    google_home_page.go
    google_home_page.search_field.value = "hi"
  end
  
  it "should create a page and update a field" do
    visit_page GooglePage do |p|
      p.search_field.value = "hi"
    end
  end
  
  it "should be on the right page" do
    visit_page GooglePage do |p|
      p.on_page_with_title?.should be_true
      p.on_page_with_text?.should be_true
      p.on_page_with_element?.should be_true
      p.on_page?.should be_true
    end  
  end
  
  it "should work when passing a block into the page class" do
    GooglePage.new(go => true) do |p|
      p.on_page_with_title?.should be_true
      p.on_page_with_text?.should be_true
      p.on_page_with_element?.should be_true
      p.on_page?.should be_true
    end
  end
  
  it "should work with element_xpath" do
    visit_page GooglePage do |p|
      p.page_title_element_from_xpath.text.should == "Google"
    end
  end
  
  it "should call the correct flow", :focus => true do
    Gosling::Flows.yay_flow
  end
  
  
  it "should clear cookies" do
    visit_page GooglePage do |p|
    end
    Gosling::Browser.clear_cookies
  end
end