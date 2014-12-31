# Cat counter using scheduler

defmodule CatScheduler do
	
	def run(process_count, cat_module, cat_func, to_count) do
		1..process_count
		|> Enum.map(fn(_) ->
										spawn(cat_module, cat_func, [self])
										end)
		|> schedule_work(to_count, [])
	end

	defp schedule_work(workers, work_queue, results) do
		receive do
			{:ready, worker} when length(work_queue) > 0 ->
				[next | tail] = work_queue
				send(worker, {:count, next, self})
				schedule_work(workers, tail, results)
			{:ready, worker} ->
				send(worker, :shutdown)
				if length(workers) > 1 do
					schedule_work(List.delete(workers, worker), work_queue, results)
				else
					Enum.sort(results, fn({n1, _}, {n2, _}) ->
																	n1 >= n2
																end)
				end
			{:answer, path, result, _worker} ->
				schedule_work(workers, work_queue, [{path, result} | results])
		after 1000 ->
						IO.puts("Oops. Nothing seems to be happening.")
						exit(:abort)
		end
	end

end

defmodule CatCounter do

	def count(scheduler) do
		# Report that I'm ready for work
		send(scheduler, {:ready, self})

		# Respond to messages
		receive do
			{:count, path, requester} ->
				send(requester, {:answer, path, _count_p(path), self})
				count(scheduler)
			:shutdown ->
				exit(:normal)
		end
	end

	def _count_p(path) do
		length(Regex.scan(~r{cat}, File.read!(path)))
	end

	def ls_files(dir) do
		File.ls!(dir)
		|> Enum.map(&(Path.join(dir, &1)))
		|> Enum.filter(&(not File.dir?(&1)))
	end

end

to_process = CatCounter.ls_files("src/your_turn")
# to_process = CatCounter.ls_files("D:/cygwin64/home/l.jones/professional/software/lib/dotnet/nhibernate/src/src/NHibernate.Test/NHSpecificTest")
max_process_count = 8

Enum.each(1..max_process_count, fn(process_count) ->
										{time, result} = :timer.tc(CatScheduler, :run,
																							 [process_count,
																								CatCounter, :count,
																								to_process])
										if process_count == 1 do
											IO.puts(inspect(result))
											IO.puts("\n     #{time} (s)")
										else
											:io.format("~2B    ~.2f~n",
																 [process_count, time / 1000000])
										end
								end)
