# Illustrates messages from monitored processes.

defmodule MonitoredMessages1 do

	def start(parent) do
		spawn_monitor(MonitoredMessages1, :send_and_exit, [parent])
	end

	def send_and_exit(pid) do
		send(pid, "Look what you've done! I'm melting, melting.")
	end

	def receive_until(wait) do
		receive do
			any ->
				IO.puts("Received: #{inspect(any)}")
			receive_until(wait)
		after wait ->
						true
		end
	end		

end

IO.puts("\nIllustrates messages from monitored processes.")

IO.puts("Creating the monitored process.")
MonitoredMessages1.start(self)

IO.puts("Sleeping for 500 ms")
:timer.sleep(500)

IO.puts("\nWhat has happened while I slept?")
MonitoredMessages1.receive_until(100)

IO.puts("\nAnd now we're done.")
