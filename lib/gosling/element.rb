module Gosling
class Element
  def initialize(search)
    @search = search
  end

  def wait_for_me(timout = 5)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    wait.until do
     #locator, location = @search.shift
     @web_driver_element = Gosling::Browser.driver.find_element(@search)
   end
   @web_driver_element
  end
  
  def method_missing(sym, *args, &block)
    wait_for_me(5)
    @web_driver_element.send sym, *args, &block
  end
end
end