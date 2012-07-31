class YayFlow < Gosling::Flow


	def perform(params)
		puts_something(params)
	end
  
  def puts_something(params)
    puts "args are #{params}"
  end
end
