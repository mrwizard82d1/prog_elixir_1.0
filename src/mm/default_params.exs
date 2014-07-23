defmodule DefaultParams do
	def func(p1, p2 \\ 2, p3 \\ 3, p4) do
		IO.inspect [p1, p2, p3, p4]
	end
end

DefaultParams.func("a", "b")
DefaultParams.func("a", "b", "c")
DefaultParams.func("a", "b", "c", "d")
