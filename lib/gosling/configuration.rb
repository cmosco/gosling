module Gosling
  module Configuration
        
    def short_timeout=(timeout)
      @short_timeout = timeout
    end
   
    def short_timeout()
      @short_timeout ||= 5
    end

    def base_url=(url)
      @base_url = url
    end

    def base_url
      @base_url ||= "http://localhost:9000"
    end
   
    def sections_path=(path)
      @sections_path = path
    end
    
    def sections_path
      @sections_path ||= "spec/sections"
    end

    def flows_path=(path)
      @flows_path = path
    end
    
    def flows_path
      @flows_path ||= "spec/flows"
    end
  end
end