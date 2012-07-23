module Gosling
  module PageFactory

    def visit_page(page_class, &block)
      on_page page_class, true, &block
    end

    def on_page(page_class, visit=false, &block)
      @current_page = page_class.new(@browser, visit)
      block.call @current_page if block
      @current_page
    end
  end
end