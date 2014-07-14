a = 1
IO.puts "a = #{a}"
IO.puts "a + 3 : #{a + 3}"
IO.puts "a = 1 : #{a = 1}"
IO.puts "1 = a : #{1 = a}"
try do
	2 = a
rescue
	 error ->
		IO.inspect error
end

simple_list = ["Humperdinck", "Buttercup", "Fezzik"]
IO.write "\nsimple_list="
IO.inspect simple_list

composite_list = ["milk", "butter", ["iocane", 12]]
IO.write "\ncomposite_list="
IO.inspect composite_list

integer_list = [1, 2, 3]
IO.write "\ninteger_list="
IO.inspect integer_list

# Matching simple lists
[a, b, c] = integer_list
IO.puts "\nMatching simple lists: a=#{a}, b=#{b}, c=#{c}"

# Matching composite lists
composite_integer_list = [1, 2, [3, 4, 5]]
[a, b, c] = composite_integer_list
IO.write "\nMatching composite lists:\n  a=#{a}, b=#{b}, c="
IO.inspect c

# Matching with literals
[a, 2, b] = integer_list
IO.puts "\nMatching with literals: a=#{a}, b=#{b}"

# Errors in matching.
try do
	IO.write "\nError matching literal:\n  "
	[a, 1, b] = integer_list
rescue
	error ->
		IO.inspect error
end

# Matching with "don't care"
IO.write "\n"
IO.inspect([1, _, _] = integer_list)
IO.inspect([1, _, _] = [1, "cat", "dog"])

# One match per binding operation
[a, a] = [1, 1]
IO.puts "\nOne match per binding: a=#{a}"
try do
	IO.write "Binding variable twice in one expression\n  "
	[a, a] = [1, 2]
rescue
	error ->
		IO.inspect error
end

# Rebinding a variable.
a = 1
IO.puts "\nFirst binding: a=#{a}"
[1, a, 3] = integer_list
IO.puts "Next binding: a=#{a}"

# Suppress re-binding.
a = 1
IO.puts "\nFirst: a=#{a}"
a = 2
IO.puts "Next: a=#{a}"
try do
	IO.write "^a = 1\n  "
	^a = 1
rescue
	error ->
		IO.inspect error
end

a = 1
IO.puts "a=#{a}"
[^a, 2, 3] = integer_list

a = 2
try do
	IO.puts "Trying to bind 2 = 1."
	[^a, 2] = [1, 2]
rescue
		error ->
		IO.inspect error
end
