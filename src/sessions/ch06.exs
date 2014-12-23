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

# Chaining terms on the same line
IO.puts("\nChaining terms on the same line.")
IO.puts("  (1..10) |> Enum.map(&(&1 * &1)) |> Enum.filter(&(&1 < 40)) ->")
IO.write("    ")
IO.inspect((1..10) |> Enum.map(&(&1 * &1)) |> Enum.filter(&(&1 < 40)))

# Module and inter-module calls.
IO.puts("\nModule and inter-module calls.")
defmodule Mod do
	def func1 do
		IO.puts("In func1")
	end
	def func2 do
		func1()
		IO.puts("In func2")
	end
end

IO.puts("Mod.func1()")
Mod.func1()
IO.puts("Mod.func2()")
Mod.func2()

# Outer and inner module scopes.
IO.puts("\nOuter and inner module scopes.")

defmodule Outer do
	defmodule Inner do
		def func do
			IO.puts("Inner.func()")
		end
	end
	
	def func do
		IO.puts("Outer.func()")
		Inner.func()
	end
end

IO.puts("Calling Outer.func() (which calls Inner.func()).")
Outer.func()
IO.puts("Calling Outer.Inner.func().")
Outer.Inner.func()

# Remember, nesting modules is an illusion.
IO.puts("\nNesting of modules is an illusion.")

defmodule Mix.Tasks.Doctest do
	def run() do
		IO.puts("Mix.Tasks.Doctest.run()")
	end
	
	def setup() do
		IO.puts("Mix.Tasks.Doctest.setup()")
	end
end

IO.puts("Calling Mix.Tasks.Doctest.run()")
Mix.Tasks.Doctest.run()

# Using the alias directive
IO.puts("\nUsing the alias directive.")

defmodule Example do
	def func() do
		alias Mix.Tasks.Doctest, as: Doctest
		Doctest.setup()
		Doctest.run()
	end
end

IO.puts("Calling Example.func() which uses aliases.")
Example.func()

# Module names: Elixir, Erlang and atoms
IO.puts("\nModule names: Elixir, Erlang and atoms.")
Dump.puts("is_atom(IO) -> ", is_atom(IO))
Dump.puts("to_string(IO) -> ", to_string(IO))
Dump.puts(":\"Elixir.IO\" === IO -> ", :"Elixir.IO" === IO)

IO.puts("Calling a function 'normally': IO.puts(123)")
IO.puts(123)

IO.puts("And oddly: :\"Elixir.IO\".puts(123)")
:"Elixir.IO".puts(123)

# Calling an Erlang function.
IO.puts("\nCalling an Erlang library function.")
IO.puts(":io.format(\"The number is ~3.1f~n\"), [5.678])")
:io.format("The number is ~3.1f~n", [5.678])
