defmodule Link2 do

	import :timer, only: [sleep: 1]

	def sad_function() do
		sleep(500)
		exit(:boom)
	end

	def run() do
		spawn_link(Link2, :sad_function, [])
		receive do
			msg ->
				IO.puts("Message received: #{inspect msg}")
		after 1000 ->
						IO.puts("Nothing happened as far as I a concerned.")
		end
	end
end

IO.puts("Linked processes kill each other when they exit.")
Link2.run()
