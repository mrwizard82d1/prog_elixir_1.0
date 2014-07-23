defmodule Arithmetic do
	def sum(0), do: 0
	def sum(n), do: n + sum(n - 1)

	def gcd(x, 0), do: x
	def gcd(x, y), do: gcd(y, rem(x, y))
end

IO.puts "Arithmetic.sum(0)=#{Arithmetic.sum(0)}"
IO.puts "Arithmetic.sum(1)=#{Arithmetic.sum(1)}"
IO.puts "Arithmetic.sum(5)=#{Arithmetic.sum(5)}"
IO.puts "Arithmetic.sum(10)=#{Arithmetic.sum(10)}"

IO.puts ""
IO.puts "Arithmetic.gcd(221, 247)=#{Arithmetic.gcd(221, 247)}"
IO.puts "Arithmetic.gcd(1081, 2773)=#{Arithmetic.gcd(1081, 2773)}"
