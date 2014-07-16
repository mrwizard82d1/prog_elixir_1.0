defmodule Immutability do
	def do_something_with(c) do
		c = 100
	end
end

count = 99
Immutability.do_something_with(count)
IO.puts "99 == count -> #{99 == count}"

array = [1, 2, 3]
Immutability.do_something_with(array)
IO.puts "[1, 2, 3] == array -> #{[1, 2, 3] == array}"

list1 = [3, 2, 1]
list2 = [4 | list1]
IO.write "list2="
IO.inspect list2
IO.puts "[3, 2, 1] == list1 -> #{[3, 2, 1] == list1}"

name = "elixir"
cap_name = String.capitalize name
IO.puts "cap_name=#{cap_name}"
IO.puts ~s(name == "elixir" -> #{name == "elixir"})
