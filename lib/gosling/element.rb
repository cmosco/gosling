module Gosling
  class Element
    
    def initialize(search, find = true)
      @search = search
      wait_for_me if find
    end
    
    def element
      @webdriver_element ||= wait_for_me
    end
  
    def value=(new_value)
      wait_for_me
      @webdriver_element.clear
      @webdriver_element.send_keys(new_value)
    end

    def wait_for_me(timeout = Gosling.short_timeout)
      return @webdriver_element unless @webdriver_element.nil?
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout) # seconds
      wait.until do
        @webdriver_element = Gosling::Browser.driver.find_element(@search)
      end
      @webdriver_element
    end
  
    def exists?
      begin
        Gosling::Browser.driver.find_element(@search)
        true
      rescue
        false
      end
    end  

    def wait_for_me_to_dissapear(timeout = Gosling.short_timeout)
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout) # seconds
      wait.until do
        !Gosling::Browser.driver.find_element(@search).displayed?
      end
    end
  
    def method_missing(sym, *args, &block)
      wait_for_me if @web_driver_element.nil?
      @webdriver_element.send sym, *args, &block
    end
  end
end