module GoogleHeader
  include Gosling::Accessors
   
  element_xpath(:image_link, "//a//span[text()='Images']")   
   
    
  def puts_something
    puts "WOW THIS WORKED."
  end
end
