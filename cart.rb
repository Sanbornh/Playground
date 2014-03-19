class Cart
	#@objects = [2]
	@dummy = "Hi there"


	def initialize(word)
		@objects = Array.new
		@dummy = word
	end

	def +(thing)
		p thing

		@objects << thing
	end

	def show_things
		@objects.each {|x| x.show_name}
	end

end

class Thing
	def initialize(name)
		@name = name
	end
	def show_name
		puts @name
	end
end

# Create a few things
apple = Thing.new("apple")
orange = Thing.new("orange")
banana = Thing.new("banana")

cart = Cart.new("My Cart")

#binding.pry

cart+apple
cart+orange
cart+banana

cart.show_things

