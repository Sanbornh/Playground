def sum_of_cubes(a,b)
	#array = Array(a..b)
	array2 = []
	Array(a..b).each { |x| array2 << x ** 3 }
	array2.inject { |x, y| x + y }
end 

puts sum_of_cubes(1, 3)