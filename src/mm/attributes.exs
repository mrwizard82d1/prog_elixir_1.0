defmodule Attributes do
	@author "Dave Thomas"
	def get_author() do
		@author
	end
end

IO.puts("\nQuerying modules attributes from a function.")
IO.puts("Attributes was written by #{Attributes.get_author()}")
