# Illustrates messages from linked processes.

defmodule LinkedMessages2 do

	def start(parent) do
		spawn_link(LinkedMessages2, :send_and_exit, [parent])
	end

	def send_and_exit(pid) do
		send(pid, "Ohhhh, what a world, what a world")
		LinkedMessages2.send_it(pid,
														"Look what you've done! I'm melting, melting.")
	end

	def send_it(pid, message, count) do
		send(pid, "Message: #{message}, Count: #{count}")
	end

	def receive_until(wait) do
		receive do
			any ->
				IO.puts("Parent received: #{inspect(any)}")
			receive_until(wait)
		after wait ->
						true
		end
	end		

end

IO.puts("\nIllustrates messages from linked processes.")

# Before creating the linked process, trap errors (otherwise you might die).
Process.flag(:trap_exit, true)

IO.puts("Creating the linked process.")
LinkedMessages2.start(self)

IO.puts("Sleeping for 500 ms")
:timer.sleep(500)

IO.puts("\nWhat has happened while I slept?")
LinkedMessages2.receive_until(100)

IO.puts("\nAnd now we're done.")
