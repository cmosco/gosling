Gosling
=========

Golsing is a page object model dsl for webdriver based on concepts borrowed from [page-object] and [site prism]

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






  
  [site prism]: https://github.com/natritmeyer/site_prism
  [page-object]: https://github.com/cheezy/page-object
  
