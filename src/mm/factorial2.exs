defmodule Factorial do
	def of(0), do: 1
	def of(n) when n > 0, do: n * of(n-1)
end

IO.puts "Factorial.of(3)=#{Factorial.of(3)}"
IO.puts "Factorial.of(7)=#{Factorial.of(10)}"
IO.puts "Factorial.of(10)=#{Factorial.of(10)}"
IO.write "Factorial.of(1000)="
large_factorial_start = String.slice "#{Factorial.of(1000)}", 0..32
IO.puts "#{large_factorial_start}..."
