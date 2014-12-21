defmodule Factorial1 do
	def of(0), do: 1
	def of(n), do: n * of(n-1)
end

IO.puts("Recursive functions (factorial)")
IO.puts "  Factorial1.of(3) -> #{Factorial1.of(3)}"
IO.puts "  Factorial1.of(7) -> #{Factorial1.of(7)}"
IO.puts "  Factorial1.of(10) -> #{Factorial1.of(10)}"
IO.write "  Factorial1.of(1000) (first 32 digits) -> "
large_factorial_start = String.slice "#{Factorial1.of(1000)}", 0..32
IO.puts "#{large_factorial_start}..."

