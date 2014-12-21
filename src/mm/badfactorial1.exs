# The anchor case is in the wrong location (the first clause ALWAYS matches).
#
# This function compile - but with a warning (and it WILL NOT work).

defmodule BadFactorial1 do
	def of(n), do: n * of(n - 1)
	def of(0), do: 1
end
