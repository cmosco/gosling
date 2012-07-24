module Gosling
  module Accessors 
    extend ActiveSupport::Concern
    
    def initialize(visit = false)
      self.go if visit == true && self.respond_to?(:go)
    end
    
    module ClassMethods
      def page_url(url)
        define_method("go") do
          url = url.kind_of?(Symbol) ? self.send(url) : url
          Gosling::Browser.driver.navigate.to(url)      
        end
      end  
        
      def element(name, search)
        define_method(name) do
          webdriver_element = Element.new(search)
          webdriver_element.wait_for_me
        end
      end
      
    end
  end
end
