require Dump


defmodule SyntacticSugar
do
	def double(n), do: n * 2

	def greet(greeting, name), do:
	(
	 IO.puts(greeting)
	 IO.puts("How YOU doin', #{name}")
	)
end

# do...end syntax is syntactic sugar.
IO.puts("do...end is syntactic sugare for keyword list.")
Dump.puts("SyntacticSugar.double(3) -> ", SyntacticSugar.double(3))

# Multiple lines in a do block are delimited by parenthese
IO.puts("\nOne can enclose multiple lines in a do block in parentheses" <>
					" - but don't do this.")
IO.puts("SyntacticSugar.greet(\"Heh!\", \"Sweetheart\")");
SyntacticSugar.greet("Heh!", "Sweetheart")

