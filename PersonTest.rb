binding.pry
include ObjectSpace
include GC
$num_people = 0

class Person
	#$num_people = 0
	def initialize(name)
		@name = name
		$num_people += 1
	end

	def display_name
		puts "Hi my name is #{@name}."
	end

	def self.display_num_people
		puts "There are #{$num_people} people."
	end

	# def self.kill(person)
	# 	person = nil
	# 	@@num_people -= 1
	# end

	def finalize
		$num_people -= 1
	end
end

person1 = Person.new("sanborn")
person2 = Person.new("Raz")

#person1.display_num_people

Person.display_num_people

person1.display_name
person2.display_name

@name = "Penelope"
#puts person1.@name
puts @name

person1 = nil

#Person.kill(person1)

Person.display_num_people

binding.pry






