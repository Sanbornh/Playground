def non_duplicated_values(values)
  values.sort!
  0.upto(values.length - 1) do |x|
    if values[x] == values[x + 1] 
      values.delete_at(x)
    end
  end
  return values
end

puts non_duplicated_values([1, 2, 2, 3, 3, 4, 5])