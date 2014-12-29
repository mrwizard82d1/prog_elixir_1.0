# Illustrates monitoring other processes.

defmodule Monitor1 do
	
	import :timer, only: [sleep: 1]

	def sad_method() do
		sleep(500)
		exit(:boom)
	end

	def run() do
		resource = spawn_monitor(Monitor1, :sad_method, [])
		IO.puts("Remember the monitor (if you want to stop monitoring): " <>
                "#{inspect(resource)}")
		
		receive do
			msg ->
				IO.puts("Message received: #{inspect(msg)}")
		after 1000 ->
						IO.puts("Nothing happened as far as I am concerned.")
		end
	end

end

IO.puts("A monitored process dies and sends the DOWN message")
Monitor1.run()
