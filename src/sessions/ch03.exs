defmodule Immutability do
	def do_something_with(c) do
		c = 100
        IO.puts "Inside do_something_with():"
        IO.puts "c -> #{c}"
	end
end

IO.puts "\nActual integer arguments are immutable."
count = 99
IO.puts "Calling `Immutability.do_something_with(count=#{count})`"
Immutability.do_something_with(count)
IO.puts "99 == count -> #{99 == count}"

IO.puts "\nActual array arguments are ALSO immutable."
array = [1, 2, 3]
IO.puts "Calling `Immutability.do_something_with(array)"
IO.write "  array="
IO.inspect array
Immutability.do_something_with(array)
IO.puts "[1, 2, 3] == array -> #{[1, 2, 3] == array}"

IO.puts "\nImmutability allows SHARING when changing structures:"
list1 = [3, 2, 1]
IO.write "list1="
IO.inspect list1
list2 = [4 | list1]
IO.write "list2="
IO.inspect list2
IO.puts "[3, 2, 1] == list1 -> #{[3, 2, 1] == list1}"

IO.puts("\nFunctions NEVER change their arguments" <> 
        " (unlike other OO languages)")
name = "elixir"
IO.puts "name=#{name}"
cap_name = String.capitalize name
IO.puts "cap_name=#{cap_name}"
IO.puts ~s(name == "elixir" -> #{name == "elixir"})
