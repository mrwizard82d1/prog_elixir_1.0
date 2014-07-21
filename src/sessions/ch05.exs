# A function is a mapping between parameters and bodies which product
# results.  
sum = fn (a, b) -> a + b end
IO.puts("sum.(1, 2) -> #{sum.(1, 2)}")

# A function need not have parameters but must be called with empty
# parentheses. 
greet = fn -> IO.puts "Hello" end
IO.puts("\ngreet.() prints \"Hello\" but returns :ok.")
IO.inspect greet.()

# You can omit the parentheses around arguments in a function
# definition ....
multiply = fn a, b -> a * b end
IO.puts("\nmultiply.(5, 6) -> #{multiply.(5, 6)}")

# ... and you can also omit them if the function has no arguments.
constant_fn = fn -> 99 end
IO.puts("\nconstant_fn.() -> #{constant_fn.()}")

# Functions use pattern matching to bind values to formal parameters.
swap_function = fn {a, b} -> {b, a} end
IO.puts("\nswap_function.({6, 8}) swaps its arguments")
IO.inspect swap_function.({6, 8})
