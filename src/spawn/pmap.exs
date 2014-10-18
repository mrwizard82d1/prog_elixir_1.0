defmodule Parallel do
	def pmap(collection, each_f) do
		collection
		|> Enum.map(&(Task.async(fn -> each_f.(&1) end)))
		|> Enum.map(&(Task.await/1))
	end
end

:io.format "~w~n", [(Enum.take (Parallel.pmap 1..1000, &(&1 * &1)), 10)]
:io.format "~w~n", [(Enum.drop (Parallel.pmap 1..1000, &(&1 * &1)), 990)]
# Trying (but failing) to use all my cores. Sigh.
# :io.format "~w~n", [(Parallel.pmap 1..1000, &(&1 * &1))]
