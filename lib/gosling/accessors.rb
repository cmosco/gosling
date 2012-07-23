module Gosling
  module Accessors 
    extend ActiveSupport::Concern
    
    module ClassMethods
      def page_url(url)
        define_method("go") do
          url = url.kind_of?(Symbol) ? self.send(url) : url
          Browser.driver.navigate.to url      
        end
      end  
      alias_method :direct_url, :page_url  
    end
  end
end
