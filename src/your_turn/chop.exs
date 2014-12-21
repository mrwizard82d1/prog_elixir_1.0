defmodule Chop do
	def guess(n, n..n), do: n
	def guess(n, lower..upper) do
		the_guess = div(lower + upper, 2)
		IO.puts("Is it #{the_guess}?")
    guess_helper(the_guess, n, lower..upper)
	end

  defp guess_helper(the_guess, n, lower.._) when the_guess > n do
    guess(n, lower..the_guess-1)
  end
  defp guess_helper(the_guess, n, _..upper) when the_guess < n do
    guess(n, the_guess+1..upper)
  end
  defp guess_helper(the_guess, n, _) do
    guess(n, the_guess..the_guess)
  end
end

IO.puts "Chop.guess(3, 3..3)=#{Chop.guess(3, 3..3)}"
IO.puts "Chop.guess(1, 1..3)=#{Chop.guess(1, 1..3)}"
IO.puts "Chop.guess(273, 1..1000)=#{Chop.guess(273, 1..1000)}"
