require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class AccessorTestPageObject
  include Gosling::Accessors
end

class AccessorTestPageObject2
  include Gosling::Accessors
end

describe Gosling::Accessors do
  before(:each) do
    @page = AccessorTestPageObject.new
    fake_element = stub(:text => "page body")
    fake_navigator = stub(:to => true)
    fake_driver = stub(:navigate => fake_navigator, :title => "page title", :find_element => fake_element)
    Gosling::Browser.stubs(:webdriver).returns(fake_driver)
    Gosling::Browser.driver.find_element(:tag_name => "body").text
  end


  describe "sections" do
    it "should add the given section with snake case name" do
      @page = AccessorTestPageObject.new
      @page.respond_to?(:puts_something).should be_false
      @page.class.send(:sections, ["google_header"])
      @page.respond_to?(:puts_something).should be_true
    end

    it "should add the given section with camel case name" do
      @page = AccessorTestPageObject2.new
      @page.respond_to?(:puts_something).should be_false
      @page.class.send(:sections, ["GoogleHeader"])
      @page.respond_to?(:puts_something).should be_true
    end
  end
  
  describe "page_url" do
    it "should add a go method to the parent class" do
      @page.respond_to?(:go).should be_false
      @page.class.send(:page_url, "lol")
      @page.respond_to?(:go).should be_true
    end
    
    it "should navigate to the page when go is called" do
      @page.class.send(:page_url, "lol")
      @page.expects(:on_page?)
      @page.go
    end
  end

  describe "match_page_title" do
    it "should add a on_page_with_title method to the page class" do
      @page.respond_to?(:on_page_with_title?).should be_false
      @page.class.send(:match_page_title, "lol")
      @page.respond_to?(:on_page_with_title?).should be_true
    end

    it "should return true if the titles match" do
      @page.class.send(:match_page_title, "page title")
      @page.on_page_with_title?.should be_true
    end

    it "should raise an exception if the titles don't match" do
      Gosling.short_timeout = 1
      @page.class.send(:match_page_title, "wrong page title")
      lambda { @page.on_page_with_title? }.should raise_error
    end
  end


  describe "match_page_text" do
    it "should add a on_page_with_text method to the page class" do
      @page.respond_to?(:on_page_with_text?).should be_false
      @page.class.send(:match_page_text, "page body")
      @page.respond_to?(:on_page_with_text?).should be_true
    end

    it "should return true if the text matches" do
      @page.class.send(:match_page_text, "page body")
      Gosling::Browser.stubs(:page_source).returns("page body")
      @page.on_page_with_text?.should be_true
    end

    it "should raise an exception if the text doesn't match" do
      Gosling.short_timeout = 1
      @page.class.send(:match_page_text, "wrong page body")
      lambda { @page.on_page_with_text? }.should raise_error
    end
  end

  describe "element" do
      it "should add a method for each element that is added to my class" do
        @page.respond_to?(:my_cool_element).should be_false
        @page.class.send(:element, :my_cool_element, {:my_cool_element => "//xpath"})
        @page.respond_to?(:my_cool_element).should be_true
      end
  end
end


   # {:match_page_element => :on_page_with_element?, :element => "my_cool_element", :element_via_name => "my_cool_element", 
   #:element_via_css => "my_cool_element", :element_via_xpath => "my_cool_element"}.each do |method_name, dynamic_name| 
   #   it "should add a method called #{dynamic_name} when my class has #{method_name} called on it" do
   #     random_method_name = "#{dynamic_name}#{Random.rand(1000).to_s}"
   #     @page.respond_to?(random_method_name).should be_false
   #     @page.class.send(method_name, random_method_name, "wat")
   #     @page.respond_to?(random_method_name).should be_true
   #   end
   # end










