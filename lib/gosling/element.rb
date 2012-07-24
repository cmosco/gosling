module Gosling
class Element
  
  def initialize(search)
    @search = search
  end
  
  def value=(new_value)
    wait_for_me
    @web_driver_element.clear
    @web_driver_element.send_keys(new_value)
  end

  def wait_for_me(timeout = 5)
    return @web_driver_element unless @web_driver_element.nil?
    wait = Selenium::WebDriver::Wait.new(:timeout => timeout) # seconds
    wait.until do
     @web_driver_element = Gosling::Browser.driver.find_element(@search)
   end
   self
  end
  
  def method_missing(sym, *args, &block)
    wait_for_me
    @web_driver_element.send sym, *args, &block
  end
end
end