defmodule Factorial2 do
	def of(0), do: 1
	def of(n) when n > 0, do: n * of(n-1)
end

IO.puts "Factorial2.of(3)=#{Factorial2.of(3)}"
IO.puts "Factorial2.of(7)=#{Factorial2.of(10)}"
IO.puts "Factorial2.of(10)=#{Factorial2.of(10)}"
IO.write "Factorial2.of(1000)="
large_factorial_start = String.slice "#{Factorial2.of(1000)}", 0..32
IO.puts "#{large_factorial_start}..."
IO.puts("Factorial of a negative number fails: Factorial2.of(-17)")
Factorial2.of(-17)
