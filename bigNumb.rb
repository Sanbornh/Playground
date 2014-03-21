a = 5123098712309172381723
puts "First 'a' = #{a}"
puts "'a' as an id of #{a.object_id}"
#p a

def adder(x)
	puts "inside adder, 'x' has an id of #{x.object_id}"
#	p x
	x = x + 2
	puts "then is is added and it has an id of #{x.object_id}"
#	p x
end

adder(a)

puts "finally, outside, 'a' has an id of #{a.object_id}"
#p a
puts "and 'a' = #{a}"
#p a

a = a + 2

puts "finally, outside, 'a' has an id of #{a.object_id}"
#p a
puts "and 'a' = #{a}"
#p a

def second_adder(x)
	puts "inside adder, 'x' has an id of #{x.object_id}"
#	p x
	x = x + 2
	puts "then is is added and it has an id of #{x.object_id}"
	return x
end

a = second_adder(a)

puts "finally, outside, 'a' has an id of #{a.object_id}"
#p a
puts "and 'a' = #{a}"
#p a
