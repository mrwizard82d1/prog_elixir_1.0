# Sophisticated sending messages to multiple processes.


require Dump


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

	def receive_all(expected), do: receive_all_p(expected)

	def receive_all_p(expected) when length(expected) == 0, do: :ok
	def receive_all_p(expected) do
		receive do
			{:ok, token} ->
				Dump.inspect("Received: ", token)
				remainder = List.delete(expected, token)
				receive_all_p(remainder)
		after 500 ->
						:timeout
		end
	end

end
			

messages = [:fred, :wilma, :barney, :betty,
						:pebbles, :"bam-bam", :dino, :"mr. rubble",
					 :bugs, :daffy, :elmer, :porky]

processes = Enum.map(messages, fn(_) ->
																		FredWilma.start()
																end)

processes
|> Enum.zip(messages)
|> Enum.each(fn({process, message}) ->
								 FredWilma.publish(process, {self, message})
						 end)

:ok = FredWilma.receive_all(messages)

processes 
|> Enum.each(fn(p) ->
								 FredWilma.stop(p)
						 end)
