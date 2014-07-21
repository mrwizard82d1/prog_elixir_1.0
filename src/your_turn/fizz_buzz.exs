fizz_buzz = fn 
							{0, 0, _} -> "FizzBuzz"
							{0, _, _} -> "Fizz"
							{_, _, value} -> value
						end
IO.puts("\nfizz_buzz.(1, 0, 7) -> #{fizz_buzz.(1, 0, 7)")
IO.puts("\nfizz_buzz.(0, 3, 11) -> #{fizz_buzz.(0, 3, 11)")
IO.puts("\nfizz_buzz.(0, 0, 13) -> #{fizz_buzz.(0, 0, 13)")

