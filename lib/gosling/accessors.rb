module Gosling
  module Accessors 
    extend ActiveSupport::Concern
    
    def initialize(visit = false)
      if visit == true && self.respond_to?(:go)
        self.go
        on_page?
      end
    end
    
    def wait_for_something_to_be_true(wait = 10)
      count = 0
      while(count < wait) do
        begin
          return true if yield
        rescue Exception => e
          raise e if count == (wait - 1)
        end
        count += 1
        sleep(1)
      end
      raise "Timed out in wait_for_something_to_be_true"
    end   
    
    def on_page?
      on_correct_page = nil
      [:on_page_with_title?, :on_page_with_text?, :on_page_with_element?].each do |mthd|
        on_correct_page ||= send(mthd) if respond_to?(mthd)
      end
      raise("No matchers found") if on_correct_page.nil?
      on_correct_page
    end  
    
    module ClassMethods
      def page_url(url)
        define_method("go") do
          url = url.kind_of?(Symbol) ? self.send(url) : url
          Gosling::Browser.driver.navigate.to(url)   
          on_page?   
        end
      end  
      
      def match_page_title(match_text)
        define_method(:on_page_with_title?) do
          self.wait_for_something_to_be_true{ Gosling::Browser.driver.title == match_text }
        end
      end  
      
      def match_page_text(match_text)
        define_method(:on_page_with_text?) do
          self.wait_for_something_to_be_true{ Gosling::Browser.driver.find_element(:tag_name => "body").text.include?(match_text) }
        end
      end  
      
      def match_page_element(locator, match_text)
        define_method(:on_page_with_element?) do
          self.wait_for_something_to_be_true{ Gosling::Browser.driver.find_element(locator).text  == match_text }
        end
      end     
      
      def element(name, search)
        define_method(name) do
          webdriver_element = Element.new(search)
          webdriver_element.wait_for_me
        end  
      end
      
      def element_via_xpath(name, search_path)
        element(name, :xpath => search_path)
      end
      
      def element_via_css(name, search_path)
        element(name, :css => search_path)
      end
      
      def element_via_id(name, search_path)
        element(name, :id => search_path)
      end
          
    end
  end
end
