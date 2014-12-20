defmodule Dump do
	def inspect(prefix, o) do
		IO.write "#{prefix}"
		IO.inspect o
	end

	def puts(prefix, o) do
		IO.puts "#{prefix}#{o}"
	end
end

