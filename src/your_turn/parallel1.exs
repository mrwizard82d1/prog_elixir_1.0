defmodule Parallel do

	def pmap(collection, func) do
		me = self
		collection |>
			Enum.map(fn(elem) ->
									 spawn_link(fn ->
																	 send(me, {self, func.(elem)})
															end)
							 end) |>
						 # Uncomment this block (and comment out the next) to
						 # ensure that results are returned in order.
						 # Enum.map(fn(pid) ->
						 # 							receive do
						 # 								{^pid, result} ->
						 # 									result
						 # 							end
						 # 					end)
						 Enum.map(fn(_) ->
						 							receive do
						 								{_pid, result} ->
						 									result
						 							end
						 					end)
	end
	
end

IO.puts("\nRunning a parallel map operation.")
# result = Parallel.pmap(1..1000, &(&1 * &1))
result = Parallel.pmap(1..100, fn(n) ->
																	 :timer.sleep(rem(n, 13))
																	 {n, n * n}
															 end)
IO.puts("Result = #{inspect(result)}")
