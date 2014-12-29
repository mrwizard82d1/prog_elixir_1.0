defmodule Dump do
	def inspect(prefix, o) do
		IO.write "#{prefix}"
		IO.inspect o
	end

	def puts(prefix, nil) do
		IO.puts("#{prefix}nil")
	end
	def puts(prefix, "") do
		IO.puts("#{prefix}\"\"")
	end
	def puts(prefix, o) do
		IO.puts "#{prefix}#{o}"
	end

	def write(prefix, nil) do
		IO.write("#{prefix}nil")
	end
	def write(prefix, "") do
		IO.write("#{prefix}\"\"")
	end
	def write(prefix, o) do
		IO.write "#{prefix}#{o}"
	end
end

