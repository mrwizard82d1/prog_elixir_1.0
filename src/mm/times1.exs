defmodule Times do
	def double(n), do: n * 2
end

IO.puts "Times.double(4)=#{Times.double(4)}"
IO.puts "Times.double(8)=#{Times.double(8)}"
IO.puts "Times.double(123)=#{Times.double(123)}"
IO.puts Times.double("cat")
