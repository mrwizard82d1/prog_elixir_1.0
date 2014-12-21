require Dump


defmodule Times do
	def double(n) do
		n * 2
	end
	
	def triple(n) do
		n * 3
	end

	def quadruple(n) do
		double (double n)
	end
end

IO.puts("\nInvoking Times.double/1:")
IO.puts "  Times.double(4)=#{Times.double(4)}"
IO.puts "  Times.double(8)=#{Times.double(8)}"
IO.puts "  Times.double(123)=#{Times.double(123)}"

IO.puts("\nTimes.double/1 throws an array if we try to double a string")
try do
	IO.puts Times.double("cat")
rescue
	ae in ArithmeticError ->
		Dump.inspect("  Rescued error: ", ae)
end

IO.puts("\nInvoking Times.triple/1:")
IO.puts "  Times.triple(4)=#{Times.triple(4)}"
IO.puts "  Times.triple(8)=#{Times.triple(8)}"
IO.puts "  Times.triple(123)=#{Times.triple(123)}"

IO.puts("\nInvoking Times.quadruple/1:")
IO.puts "Times.quadruple(4)=#{Times.quadruple(4)}"
IO.puts "Times.quadruple(8)=#{Times.quadruple(8)}"
IO.puts "Times.quadruple(123)=#{Times.quadruple(123)}"
