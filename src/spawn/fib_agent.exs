# Using agents improve Fibonacci efficiency.

defmodule FibAgent do
	
	def start_link() do
      # Create the cache for Fibonacci numbers.
      cache = Enum.into([{0, 0}, {1, 1}], HashDict.new())

      # Create a process with the cache as its state.
      Agent.start_link(fn() -> cache end)
	end

	# Calculate the nth Fibonacci number caching intermediate results.
	def fib(pid, n) when n >= 0 do
      # Gets the nth Fibonacci number updating the cache using the
      # specified function. The function takes two arguments. The first
      # argument contains the cached Fibonacci values.
      Agent.get_and_update(pid, &do_fib(&1, n))
	end

	# Private helper method to calculate the nth Fibonacci number using
	# a cache of previously calculated Fibonacci numbers.
	defp do_fib(cache, n) do
      # If the nth Fibonacci number is already in the cache
      if cached = cache[n] do
          # Return it - along with the (unchanged) cache.
          {cached, cache}
      else
          # Get the (n-1)st Fibonacci number
          {fib_n_1, cache} = do_fib(cache, n - 1)

          # Since we've calculated the (n-1)st Fibonacci number, the
          # (n-2)st Fibonacci number MUST already be in the cache
          # (because n-2 < n-1 for all n).
          result = fib_n_1 + cache[n-2]

          # And now we can return the result with the updated cache. 
          {result, Dict.put(cache, n, result)}
    end
  end

end

{:ok, agent} = FibAgent.start_link()
[0, 1, 2, 3, 4, 5, 2000]
  |> Enum.each(fn(n) ->
    IO.puts("The #{n}th Fibonacci number is #{FibAgent.fib(agent, n)}")
  end) 
