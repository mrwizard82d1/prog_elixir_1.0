IO.write("\nSimple pattern matching\n")
a = 1
IO.puts "a = #{a}"
IO.puts "a + 3 -> #{a + 3}"
IO.puts "a = 1 -> #{a = 1}"
IO.puts "1 = a -> #{1 = a}"
try do
  IO.write "2 = a -> "
  2 = a  
rescue
  error ->
    IO.inspect error
end

IO.write("\n\nSimple list: ")
simple_list = ["Humperdinck", "Buttercup", "Fezzik"]
IO.inspect simple_list

IO.write("\n\nComposite list: ")
composite_list = ["milk", "butter", ["iocane", 12]]
IO.inspect composite_list

IO.write("\n\nSimple integer list: ")
integer_list = [1, 2, 3]
IO.inspect integer_list

# Matching simple lists
IO.write("\n\nMatching simple list: ")
IO.write("\n[a, b, c] = integer_list -> ")
[a, b, c] = integer_list
IO.puts "a=#{a}, b=#{b}, c=#{c}"

# Matching composite 
IO.write("\n\nMatching composite list: ")
IO.write("\ncomposite_integer_list = [1, 2, [3, 4, 5]]")
composite_integer_list = [1, 2, [3, 4, 5]]
IO.write("\n[a, b, c] = composite_integer_list -> ")
[a, b, c] = composite_integer_list
IO.write "a=#{a}, b=#{b}, c="
IO.inspect c

# Matching with literals
IO.write("\n\nMatching with literal: ")
IO.write("\n[a, 2, b] = integer_list -> ")
[a, 2, b] = integer_list
IO.puts "a=#{a}, b=#{b}"

# Errors in matching.
IO.write("\n\nErrors in matching")
try do
	IO.write "\nA literal -> "
	[a, 1, b] = integer_list
rescue
	error ->
		IO.inspect error
end

# Matching with "don't care"
IO.write("\n\nMatching with \"don't care.\"")
IO.write "\n"
IO.inspect([1, _, _] = integer_list)
IO.inspect([1, _, _] = [1, "cat", "dog"])

# One match per binding operation
IO.write "\n\nVariable matches ONCE in a binding operation"
IO.write "\n[a, a] = [1, 1] -> "
[a, a] = [1, 1]
IO.puts "a=#{a}"
try do
	IO.write "Binding variable twice in one expression"
    IO.write "\n[a, a] = [1, 2] => "
	[a, a] = [1, 2]
rescue
	error ->
		IO.inspect error
end

# Rebinding a variable.
IO.write "\n\nRebinding a variable"
a = 1
IO.puts "\nFirst binding: a=#{a}"
[1, a, 3] = integer_list
IO.puts "Next binding: a=#{a}"

# Suppress re-binding.
IO.write "\n\nSupress re-binding (Erlang behavior)"
a = 1
IO.puts "\nFirst: a=#{a}"
a = 2
IO.puts "Next:  a=#{a}"
try do
  IO.write "^a = 1 -> "
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
    IO.write "[^a, 2] = [1, 2] -> "
	[^a, 2] = [1, 2]
rescue
  error ->
	IO.inspect error
end
