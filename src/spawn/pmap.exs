defmodule Parallel do
	def pmap(collection, each_f) do
		me = self
		collection
		|> Enum.map(fn (item) ->
										 spawn_link fn -> (send me,
																			 {self, each_f.(item)})
																end
								end)
		|> Enum.map(fn (pid) ->
										 receive do
											 { ^pid, result } -> result
										 end
								end)
	end
end

:io.format "~w~n", [(Enum.take (Parallel.pmap 1..1000, &(&1 * &1)), 10)]
:io.format "~w~n", [(Enum.drop (Parallel.pmap 1..1000, &(&1 * &1)), 990)]
