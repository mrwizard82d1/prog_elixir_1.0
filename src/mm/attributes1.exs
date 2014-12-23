require Dump


defmodule Attributes1 do
	@attr "one"
	def first, do: @attr
	@attr "two"
	def second, do: @attr
end

IO.puts("\nA function returns the value of the attribute" <>
					" at the time the function was defined.")
Dump.puts("Attributes1.first() -> ", Attributes1.first())
Dump.puts("Attributes1.second() -> ", Attributes1.second())
