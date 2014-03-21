# def kaprekar?(k)
#   number = (k * k)
#   digits = number.to_s.length / 2
#   first_half = number[0..digits]
#   second_half = number[digits + 1..number.length - 1]
#   if first_half.to_i + second_half.to_i == k 
#     return true
#   else
#     return false
#   end
# end

binding.pry

def kaprekar?(k)
  first_half = []
  second_half = []
  array = (k * k).to_s.scan(/./)
  0.upto((array.count / 2)-1) { |x| first_half << array[x] }
  (array.count / 2).upto(array.length - 1) { |x| second_half << array[x] }
  if first_half.join.to_i + second_half.join.to_i == k then return true end
end


puts kaprekar?(9)