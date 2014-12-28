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

# A hung process while waiting for responses from a dead process.
IO.puts("\nIllustrate a process hanging while waiting for a message")
IO.puts("from a dead process.")

IO.puts("Spawn the (single-shot) greet process.")
pid = spawn(Spawn2, :greet, [])

IO.puts("Send a message and...")
send(pid, {self, "Concurrent World"})

IO.puts("...wait for the response.")
receive do
	{:ok, response} ->
		IO.puts(response)
end

# Uncomment the following region to illustrate hanging.
# IO.puts("\n!!! WARNING !!! This code will hang.")
# IO.gets("Press any key when ready...")
# IO.puts("Now send the second message and...")
# send(pid, {self, "Another Elixir World"})

# IO.puts("...hang waiting for a response from a 'dead' greet process.")
# receive do
# 	{:ok, response} ->
# 		IO.puts(response)
# end
