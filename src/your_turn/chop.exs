defmodule Chop do
	def guess(n, n..n), do: n
	def guess(n, lower..upper) when div(lower + upper, 2) == n, do: n
	def guess(n, lower..upper) do
		the_guess = div(lower + upper, 2)
		IO.puts "Is it #{the_guess}?"
		if is_lower(the_guess, n) do
			guess(n, the_guess..upper)
		else
			guess(n, lower..the_guess)
		end
	end

	def is_lower(the_guess, n), do: the_guess < n
end

IO.puts "Chop.guess(3, 3..3)=#{Chop.guess(3, 3..3)}"
IO.puts "Chop.guess(1, 1..3)=#{Chop.guess(1, 1..3)}"
IO.puts "Chop.guess(273, 1..1000)=#{Chop.guess(273, 1..1000)}"
