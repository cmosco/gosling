module Gosling
class Element
  def initialize(locator, matcher = :xpath)
    @element_localtor = locator
    @matcher = matcher
  end

  def wait_for_me(timout = 5)
   wait = Object::Selenium::WebDriver::Wait.new({:timeout => timeout, :message => "Element not present in #{timeout} seconds"})  
   wait.until do
     @web_driver_element = @@driver.find(@matcher, @locator)
   end
  end
  
  def method_missing(sym, *args, &block)
    wait_for_me
    @web_driver_element.send sym, *args, &block
  end
end
end