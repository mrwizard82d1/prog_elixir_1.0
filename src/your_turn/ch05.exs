# List concatenation function.
list_concat = fn(a, b) -> a ++ b end
IO.write("\nlist_concat.([1, 2, 3], [4, 5, 6]) -> ")
IO.inspect list_concat.([1, 2, 3], [4, 5, 6])

# Sum function.
sum = fn(a, b, c) -> a + b + c end
IO.puts("\nsum.(1, 2, 3) -> #{sum.(1, 2, 3)}")

# Pair tuple to list converter.
pair_tuple_to_list = fn ({a, b}) -> [a ,b] end
IO.puts("\npair_tuple_to_list.({8, 7}) -> ")
IO.inspect pair_tuple_to_list.({8, 7})

# Define function fizz_buzz/1.
fizz_buzz_helper = fn 
										 (0, 0, _) -> "FizzBuzz"
										 (0, _, _) -> "Fizz"
										 (_, 0, _) -> "Buzz"
										 (_, _, value) -> value
									 end
IO.puts("\nA helper for fizz buzz.")
IO.puts("fizz_buzz_helper.(1, 1, 7) -> #{fizz_buzz_helper.(1, 1, 7)}")
IO.puts("fizz_buzz_helper.(0, 3, 11) -> #{fizz_buzz_helper.(0, 3, 11)}")
IO.puts("fizz_buzz_helper.(7, 0, 17) -> #{fizz_buzz_helper.(7, 0, 17)}")
IO.puts("fizz_buzz_helper.(0, 0, 13) -> #{fizz_buzz_helper.(0, 0, 13)}")

fizz_buzz = fn
							n ->
								fizz_buzz_helper.(rem(n, 3), rem(n, 5), n)
						end
Enum.each [{10, "Buzz"}, {11, 11}, {12, "Fizz"},
					 {13, 13}, {14, 14}, {15, "FizzBuzz"}, {16, 16}],
		 fn
			 {n, result} when n in [10, 12, 15] ->
					IO.write("fizz_buzz.(#{n}) expects ")
					IO.inspect result
					IO.write("fizz_buzz.(#{n}) returns ")
					IO.inspect fizz_buzz.(n)
			 {n, result} ->
					IO.puts("fizz_buzz.(#{n}) expects #{result}: #{fizz_buzz.(n)}")
		 end

# Define the prefix function.
prefix = fn preface ->
							fn the_rest ->
									 "#{preface} #{the_rest}"
							end
				 end
mrs = prefix.("Mrs.")
IO.write "mrs.(\"Smith\") -> "
IO.inspect mrs.("Smith")
IO.write "prefix.(\"Elixir\").(\"Rocks\") -> "
IO.inspect prefix.("Elixir").("Rocks")

# Using & shortcuts.
IO.inspect Enum.map [1, 2, 3, 4], &(&1 + 2)
Enum.each [1, 2, 3, 4], &IO.inspect/1