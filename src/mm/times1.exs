defmodule Times1 do
	def double(n), do: n * 2
end

IO.puts("Invoking Times1.double/1")
IO.puts "  Times1.double(4)=#{Times1.double(4)}"
IO.puts "  Times1.double(8)=#{Times1.double(8)}"
IO.puts "  Times1.double(123)=#{Times1.double(123)}"
IO.puts("\nTimes1.double(\"cat\")")
IO.puts Times1.double("cat")
