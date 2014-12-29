# Module illustrating sending messages to multiple process.

defmodule FredWilma do
	
	def start() do
		spawn(FredWilma, :subscribe, [])
	end

	def subscribe() do
		receive do
			{requester, token} ->
				send(requester, {:ok, token})
				subscribe()
			:stop ->
				true
		end
	end

	def publish(pid, token) do
		send(pid, token)
	end

	def stop(pid) do
		send(pid, :stop)
	end
	
end
			
process1 = FredWilma.start()
process2 = FredWilma.start()
FredWilma.publish(process1, {self, :fred})
FredWilma.publish(process2, {self, :wilma})

receive do
	result ->
		IO.inspect(result)
end
receive do
	result ->
		IO.inspect(result)
end
send(process1, :stop)
send(process2, :stop)
