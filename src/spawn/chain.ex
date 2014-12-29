defmodule Chain do
	
	# Forward the number to the next process.
	def counter(next_pid) do
		receive do
			n -> send(next_pid, n + 1)
		end
	end

	# Create a number of processes.
	def create_processes(n) do
		# Create a sequence of chained processes
		last = Enum.reduce(1..n, self,
													fn(_, send_to) ->
															spawn(Chain, :counter, [send_to])
													end)
		
		# Start the chain by sending 0 to the last item in the chain.
		send(last, 0)
							
		# And wait for the response from the chain.
		receive do
			final_answer when is_integer(final_answer) ->
				"Result is #{inspect(final_answer)}"
		end
	end

	def run(n) do
		IO.puts(inspect(:timer.tc(Chain, :create_processes, [n])))
	end

end