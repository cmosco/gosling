class TestFlow < Gosling::Flow

	def perform
		puts_something
	end
  
  def puts_something
    puts "something"
  end
end
