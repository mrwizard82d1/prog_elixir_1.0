# This is the correct way to handle default parameters with other clauses.
defmodule DefaultParams2 do
	def func(p1, p2 \\ 123)
	def func(p1, p2) when is_list(p1) do
		"You said #{p2} with a list."
	end
	def func(p1, p2) do
		"You passed in #{p1} and #{p2}."
	end
end

IO.puts("\nDefault parameters.")
IO.puts("\nSpecify all arguments")
IO.puts("DefaultParms2(1, \"dolor\") -> #{DefaultParams2.func(1, "dolor")}")

IO.puts("\nA list, a list!")
IO.puts("DefaultParams2.func('dolor', 1) -> #{DefaultParams2.func('dolor', 1)}")

IO.puts("\nUtilize defaults")
IO.puts("DefaultParams2.func(3.14) -> #{DefaultParams2.func(3.14)}")
