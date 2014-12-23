require Dump


defmodule Example do
	def func1 do
		List.flatten([1, [2, 3], 4])
	end

	def func2 do
		import List, only: [flatten: 1]
		flatten [5, [6, 7], 8]
	end
end

IO.puts("\nAn import example.")
Dump.inspect("Example.func1() flattens [1, [2, 3], 4] -> ", Example.func1())
Dump.inspect("Exmaple.func2() flattens [5, [6, 7], 8] -> ", Example.func2())
