# Correct Spawn3 module to not exit after handling first request

defmodule Spawn4 do
	def greet() do
		receive do
			{sender, msg} ->
				send(sender, {:ok, "Hello, #{msg}, from Elixir!"})
				greet()
		end
	end
end
