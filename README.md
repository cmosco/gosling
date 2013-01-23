Gosling
=========

Golsing is a page object model dsl for webdriver based on concepts borrowed from [page-object] and [site prism]. 
The goal of Gosling is to make writing page objects faster, without abstracting webdriver out of your code. This allows
you to interact with elements in a way that you are accustomed to.

Pages
=========

You can add Gosling to your page object via a simple include:

````ruby
class GoogleSearchPage
  include Gosling::Accessors
end
````

From there, you can define the page's base url:
````ruby
page_url("http://www.google.com")
````

which will automatically add the following method to your page class:
````ruby
go
````

Tell gosling how to tell if it's on the correct page:
````ruby
match_page_title("Google")
match_page_text("Search")
match_page_element({:xpath => "//title"}, "Google")
````

which will result in the following methods being added dynamically to your page class:

````ruby
 on_page_with_title?
 on_page_with_text?
 on_page_with_element?
 on_page?
````

Next, define html elements that you would like to interact with:
````ruby
element(:search_field, :name => "q")
element_xpath(:page_title, "//title")  
````
This will then automatically add the following methods to your page class:
````ruby
search_field
page_title
````
which both return webdriver elements.

You can even include common ui elements defined in a shared file:
````ruby
sections([:GoogleHeader])
````

Putting it all together, a simple page object class for the google home page might look like this:
````ruby
class GooglePage
  include Gosling::Accessors
  
  page_url("http://www.google.com")
	element(:search_field, :name => "q")
	element_xpath(:page_title_element_from_xpath, "//title")  
	match_page_title("Google")
	match_page_text("Search")
	match_page_element({:xpath => "//title"}, "Google")
	sections([:GoogleHeader])
end
````

But wait....
=========

By default, Gosling provides a few key built in wait's when accessing html elements. 

1. Page wait's - As you navigate from page to page, Gosling will use the values from your match_page_xxxx methods to block all other execution from happening until that page has been reached.
2. Element wait's - These happen every time you access an element on the page for the first time.

Code written directly in webdriver that would look like this:

````ruby
wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
wait.until do
  link = webdriver.find_element(:xpath, "/some/element")
end
link.click

wait = Selenium::WebDriver::Wait.new(:timeout => timeout) # seconds
wait.until do
  @on_right_next_page_element = webdriver.find_element(:xpath, "/some/element2")
end

wait.until do
  next_link = webdriver.find_element(:xpath, "/some/element3")
end
link.click


````
Now becomes:

````ruby
test_page_one = TestPageOne.new
test_page_one.link_to_test_page_two.click

test_page_two = TestPageTwo.new
test_page_two.another_link.click
````

Blocks
=========

There are two ways of interacting with your pages. First, you can create a new page object and then call its methods:

````ruby
google_home_page = GooglePage.new
google_home_page.go
google_home_page.image_link.click
````

However, if you're going to be performing many actions on the same object, performing your actions inside of a block
may make things more readable:

````ruby
GooglePage.new(:go => true) do |p|
  p.perform_action
  p.click
  p.text.value = "foo"
  p.do_something_else
end  
````

Sections
=========

A section defines common ui elements or methods that you can share accross multiple pages. This is useful for things like header or footer navigation that does not change from page to page. Simplly add the module name to the array of sectoins
in your page object and the methods will automatically be added to your class.

````ruby
module GoogleHeader
  include Gosling::Accessors
   
  element_xpath(:image_link, "//a//span[text()='Images']")   
    
  def puts_something
    puts "WOW THIS WORKED."
  end
end
````

Flows
=========
A flow helps you to reduce code duplication by creating a single way to run through common UI paths. For example, a
flow could be used to create and log in a user at the start of every test.

````ruby
class RegisterNewUser
  def perform
    register
    login
  end
  
  def register
    #create a new user
  end
  
  def login
    #log in as newly created user
  end
end
````

A flow can be executed by executing the following. Note that perform is called automatically.
````ruby
Gosling::Flows.register_new_user
````

Configuration
========
Gosling makes use of a few standard settings that need to be configured in your spec_helper.rb

````ruby
Gosling.short_timeout = 10
Gosling.sections_path = File.join(File.dirname(__FILE__), "sections")
Gosling.flows_path = File.join(File.dirname(__FILE__), "flows")
````

A full list of configs can be found in Gosling::Configuration


RSPEC
========
Putting it all together, a simple rspec test would look like this:

````ruby
  it "should enter in a search term on the google home page" do
    GooglePage.new(:go => true) do |p|
      p.on_page_with_title?.should be_true
      p.on_page_with_text?.should be_true
      p.on_page_with_element?.should be_true
      p.on_page?.should be_true  
      p.search_field.value = "hi"
    end
  end
````

What's next
=======
1. Custom Rspec matchers
2. Cleanup
  
  [site prism]: https://github.com/natritmeyer/site_prism
  [page-object]: https://github.com/cheezy/page-object
  
