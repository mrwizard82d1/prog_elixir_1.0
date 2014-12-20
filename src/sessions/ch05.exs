require Dump

# A function is a mapping between parameters and bodies which product
# results.  
sum = fn (a, b) -> a + b end
Dump.puts("sum.(1, 2) -> ", sum.(1, 2))

# A function need not have parameters but must be called with empty
# parentheses. 
greet = fn -> IO.puts "Hello" end
IO.puts("\nA function with no arguments " <> 
					"MUST be called with empty parentheses.")
IO.puts("greet.() prints \"Hello\" but returns :ok.")
IO.inspect greet.()

# You can omit the parentheses around arguments in a function
# definition ....
IO.puts("\nOne can omit the parenthesis around arguments "
				<> "in a function definition")  
multiply = fn a, b -> a * b end
Dump.puts("multiply.(5, 6) -> ", multiply.(5, 6))

# ... and you can also omit them if the function has no arguments.
IO.puts("... and if the function has no arguments.")
constant_fn = fn -> 99 end
Dump.puts("constant_fn.() -> ", constant_fn.())

# Functions use pattern matching to bind values to formal parameters.
IO.puts("\nFunction use pattern matching "
				<> "to bind values to formal parameters.")  
swap_function = fn {a, b} -> {b, a} end
Dump.inspect("swap_function.({6, 8}) swaps its arguments -> ",
						 swap_function.({6, 8}))

# Functions that match different parameters.
handle_open = fn
								{:ok, file} ->
									"Read data: #{IO.read(file, :line)}"
								{_, error} ->
									"Error: #{:file.format_error(error)}"
							end
IO.puts("\nHandle successfully opening a file....")
IO.puts(handle_open.(File.open("src/intro/hello.exs")))
IO.puts("... and failing to open a file.")
IO.puts(handle_open.(File.open("non-existant_file")))

# Functions returning functions.
IO.puts("\nFunctions returning functions.")
fun1 = fn -> (fn -> "Hello" end) end
other = fun1.()
IO.write("Evaluate the outer function: ")
IO.inspect other
IO.puts("And evaluate the inner function: #{other.()}")

# Functions act as closures over defined environment.
IO.puts("\nFunctions are closures.")
IO.puts("Greeter closes over name.")
greeter = fn name -> (fn -> "Hello, #{name}" end) end
IO.puts("dave_greeter closes over \"Dave\".")
dave_greeter = greeter.("Dave")
IO.puts("And now we greet Dave: #{dave_greeter.()}")

# Ahh... the adder.
IO.puts("\nThe (black) adder.")
add_n = fn n -> (fn m -> m + n end) end
IO.puts("add_two.(n) remembers its argument.")
add_two = add_n.(2)
IO.puts("And now we add many numbers to 2:")
Enum.each [3, 5, 8], fn m ->
													IO.puts("add_two.(#{m}) -> #{add_two.(m)}")
										 end

# Passing functions as arguments.
IO.puts("\nPassing functions as arguments.")
IO.puts("Defining the time_2/1 function.")
times_2 = fn n -> n * 2 end
IO.puts("Apply this function to other arguments.")
apply = fn fun, value -> fun.(value) end
IO.puts("And now, apply.(times_2, 6) -> #{apply.(times_2, 6)}")

IO.puts("\nPassing functions to Enum.map/2.")
IO.write "Apply functions to the list: "
list = [1, 3, 5, 7, 9]
IO.inspect list
IO.write "Double the list: "
IO.inspect Enum.map list, fn n -> n * 2 end
IO.write "Square the list: "
IO.inspect Enum.map list, fn n -> n * n end
IO.write "Test the list: "
IO.inspect Enum.map list, fn n -> n > 6 end

IO.puts "\nUsing anonymous function short cuts."
IO.puts "Adding 1 to its argument."
add_one = &(&1 + 1)
IO.puts "add_one.(44)=#{add_one.(44)}"
IO.puts "Squaring its argument."
square = &(&1 * &1)
IO.puts "square.(8)=#{square.(8)}"
IO.puts "Writing its argument to standard out."
speak = &(IO.puts(&1))
IO.write "speak.(\"Hello\"): "
speak.("Hello")

IO.puts "Elixir maps between anonymous functions and built-ins."
IO.inspect &(IO.puts(&1))
IO.puts "But the arguments must be in the correct order."
IO.write "&(Float.round(&1, &2)): "
IO.inspect &(Float.round(&1, &2))
IO.write "&(Float.round(&2, &1)): "
IO.inspect &(Float.round(&2, &1))

IO.puts "\nWe can also turn lists and tuples into functions."
IO.write "&{div(&1, &2), rem(&1, &2)}: "
divrem = &{div(&1, &2), rem(&1, &2)}
IO.inspect divrem
IO.write "divrem.(13, 5)="
IO.inspect divrem.(13, 5)

IO.puts "\nWe can quickly make anonymous functions by prefacing"
IO.puts "fun/arity expressions by an ampersand (&)"
l = &length/1
IO.write "&length/1 -> "
IO.inspect l
IO.puts "l.([1, 3, 5, 7]) -> #{l.([1, 3, 5, 7])}"
len = &Enum.count/1
IO.write "&Enum.count/1 -> "
IO.inspect &Enum.count/1
IO.puts "len.([1, 3, 5, 7]) -> #{len.([1, 3, 5, 7])}"
IO.write "&Kernel.min/2 -> "
IO.inspect &Kernel.min/2
m = &Kernel.min/2
IO.puts "m.(99, 88) -> #{m.(99, 88)}"

IO.puts "\nFinally, we can use the & shortcut to pass functions"
IO.puts " To other functions."
IO.write "Enum.map [1, 2, 3, 4], &(&1 + 1) -> "
IO.inspect Enum.map [1, 2, 3, 4], &(&1 + 1)
IO.write "Enum.map [1, 2, 3, 4], &(&1 * &1) -> "
IO.inspect Enum.map [1, 2, 3, 4], &(&1 * &1)
IO.write "Enum.map [1, 2, 3, 4], &(&1 < 3) -> "
IO.inspect Enum.map [1, 2, 3, 4], &(&1 < 3)
