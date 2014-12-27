# Execute a basic greeting function in the compiled module, SpawnBasic1.
# elixirc src/spawn/spawn-basic.ex
IO.puts("\nRunning the greeting function.")
SpawnBasic.greet()

# Sending messages between processes.
# elixirc src/spawn/spawn1.ex
IO.puts("\nSpawning the greeting function and interacting via messages.")
pid = spawn(Spawn1, :greet, [])

# The message was sent asynchronously (and a response was returned).
# What was it?
IO.puts("Send a message asynchronously to the new process.")
send(pid, {self, "World"})
IO.puts("And then wait for a response.")
receive do
	{:ok, message} ->
		IO.puts(message)
end
