defmodule Parallel do

	def pmap(collection, func) do
		me = self
		collection |>
			Enum.map(fn(elem) ->
									 spawn_link(fn ->
																	 send(me, {self, func.(elem)})
															end)
							 end) |>
						 Enum.map(fn(pid) ->
													receive do
														{^pid, result} ->
															result
													end
											end)
	end
	
end

IO.puts("\nRunning a parallel map operation.")
result = Parallel.pmap(1..10, &(&1 * &1))
IO.puts("Result = #{inspect(result)}")
