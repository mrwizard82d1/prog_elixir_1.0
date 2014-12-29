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


# We now "fix" the issue from Spawn2 by not waiting for a response forever.

# Create the process.
IO.puts("\nIllustrate waiting a finite time for a response.")
pid = spawn(Spawn3, :greet, [])

# Send a message.
IO.puts("Sending the first message...")
send(pid, {self, "Elixir World"})

IO.puts("...and waiting for the response.")
receive do
	{:ok, response} ->
		IO.puts(response)
end

IO.puts("Sending the second message: 'Kermit', and...")
send(pid, {self, "Kermit"})

IO.puts("...wait for a response - but not forever.")
receive do
	{:ok, response} ->
		IO.puts(response)
after 500 ->
				IO.puts("No response from the greeter.")
end

# After changing Spawn3 to handle multiple requests.

IO.puts("\nChange the spawned process to handle multiple requests.")

# Create the process.
pid = spawn(Spawn4, :greet, [])

# Send a(n asynchronous) message.
IO.puts("Sending the first message...")
send(pid, {self, "Spawn4 World"})

IO.puts("...and wait for a response.")
receive do
	{:ok, response} ->
		IO.puts(response)
end

IO.puts("Sending the second message...")
send(pid, {self, "Kermit and Ms. Piggy"})

IO.puts("...and it responds again!")
receive do
	{:ok, response} ->
		IO.puts(response)
after 500 ->
				IO.puts("Hmmm. Where's the greeter?")
end

# A properly tail-recursive factorial function.
IO.puts("\nA propertly tail-recursive factorial implemantation.")

Enum.each([0, 1, 2, 3, 5, 8,
					 # 13, 21, 34, 55, 89, 144, 233, 377,
					 # 610, 987, 1587
					],
					fn(n) ->
							{elapsed, result} = :timer.tc(TailRecursive,
																						:factorial, [n])
							Dump.puts(:io_lib.format("TailRecursive.factorial(~w) = ",
																			 [n]),
												TailRecursive.factorial(n))
							Dump.write("  took ", elapsed / 1000000)
							IO.puts(" sec.")
					end)

# Run a sequence of chains.
IO.puts("\nRun a sequence of chains.")
IO.puts("If an error occurs mentioning a system limit,")
IO.puts("you may need to invoke:")
IO.puts("'elixir --erl \"+P 1000000\" src/sessions/ch14.exs'")

Chain.run(10)
Chain.run(100)
Chain.run(1000)
Chain.run(10000)
Chain.run(100000)

# Uncomment to see system limit error.
# Chain.run(1000000)