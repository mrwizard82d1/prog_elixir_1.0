# Decimal integers
i = 1234
IO.puts "Decimal: 1234=#{i}"
j = 0xcafe
IO.puts "Hexadecimal: 0xcafe=#{j}"
k = 0765
IO.puts "Octal: 0765=#{k}"
l = 0b1010
IO.puts "Binary: 0b1010=#{l}"
m = 1_000_000
IO.puts "With separators: 1_000_000=#{m}"

defmodule Factorial do
	def of(0) do
		1
	end
	def of(n) when n >= 0 do
		n * Factorial.of(n - 1)
	end
end

defmodule Dump do
	def inspect(prefix, o) do
		IO.write "#{prefix}"
		IO.inspect o
	end

	def puts(prefix, o) do
		IO.puts "#{prefix}#{o}"
	end
end

long_integer_text ="#{Factorial.of(10000)}"
IO.puts "\nArbitrary sized integers: Factorial.of(10000)="
IO.puts "  #{String.slice(long_integer_text, 0..32)}..."

IO.puts "\nFloating point numbers"
IO.puts "1.0=#{1.0}"
IO.puts "0.2456=#{0.2456}"
IO.puts "0.314158e1=#{0.314158e1}"
IO.puts "314159.0e-5=#{314159.0e-5}"

# Atoms
IO.puts "\nSome atoms:"
Enum.each([:fred, :is_binary?, :var@2, :<>, :===,
					 :"func/3", :"long john silver"], &(Dump.inspect "  ", &1))

# Ranges
IO.puts "\nRanges"
IO.inspect 1..43
IO.inspect 3.14..3.15
Enum.each 1..7, fn n -> IO.write n end
IO.puts ""

# Regular expressions
IO.puts "\nRegular expressions (regex's)"
Enum.each [{&Regex.run/2, "Regex.run"}, {&Regex.scan/2, "Regex.scan"},
					 {&Regex.split/2, "Regex.split"},
					 {&Regex.replace/3, "Regex.replace", "*"}],
		 fn invocation ->
					if tuple_size(invocation) == 2 do
						{regex_f, regex_f_text} = invocation
						result = regex_f.(~r{[aeiou]}, "caterpillar")
  					IO.write ~s|#{regex_f_text} ~r{[aeiou]}, "caterpillar"=|
					else 
						{regex_f, regex_f_text, other} = invocation
						result = regex_f.(~r{[aeiou]}, "caterpillar", other)
  					IO.write ~s|#{regex_f_text} ~r{[aeiou]}, "caterpillar", #{other}=|
					end
				 IO.inspect result
		 end

# PIDs and references
Dump.inspect "\nPID: ", self()
Dump.inspect "make_ref() = ", make_ref()

# Tuples
IO.puts "\nTuples"
IO.inspect {1, 2}
state_tuple = {:ok, 42, "next"}
IO.inspect state_tuple
IO.inspect {:error, :enoent}
IO.puts "Typically, 2-4 items; otherwise, consider maps or structs."
{status, count, action} = state_tuple
IO.puts "status=#{status}, count=#{count}, action=#{action}"

filename = "src/sessions/ch04.exs"
{status, file} = File.open(filename)
Dump.inspect "status=#{status}, file=", file
File.close(file)

# Idiomatic matching for :ok status.
{ok, file} = File.open(filename)
Dump.inspect "Successfully opened file: ", file

try do
	no_such_filename = String.replace filename, "exs", "ext"
	{:ok, file} = File.open(no_such_filename)
	IO.puts "Oops. Opened file #{no_such_filename}."
rescue
  _ ->
		IO.puts "Expected to fail - and failed."
end

# Lists
IO.puts "\nLists"
Dump.inspect "Concatenate: ", [1, 2, 3] ++ [4, 5, 6]
Dump.inspect "Difference: ", [1, 2, 3, 4] -- [2, 4]
IO.puts "Membership: 4 in [1, 2, 3, 4] -> #{4 in [1, 2, 3, 4]}"
IO.puts "Membership: 5 in [2, 3, 4] -> #{5 in [2, 3, 4]}"

# Keyword lists
kw_list = [name: "Dave", city: "Dallas", likes: "Programming"]
IO.puts "\nKeyword lists: "
Dump.inspect("  ", kw_list)
IO.puts "Are treated as lists of keyword-value pairs:"
Enum.map kw_list, &(Dump.inspect "  ", &1)
IO.puts "Keyword lists can have duplicated keys:"
Dump.inspect "  ", [foo: "bar", bar: "baz", foo: "barbaz"]

IO.puts "A keyword list which is the last in a context in which"
IO.puts "a list is expected need not be surrounded by brackets."
Dump.inspect("  [1, fred: 1, dave: 2]=", [1, fred: 1, dave: 2])

# Maps
IO.puts "\nMaps"
states = %{"AL" => "Alabama", "WI" => "Wisconsin"}
Dump.inspect("state=", states)
response_types = %{{:error, :enoent} => :fatal,
									 {:error, :busy} => :retry}
Dump.inspect("response_types=", response_types)
colors = %{:red => 0xff0000, :green => 0x00ff00, :blue => 0x0000ff}
Dump.inspect "colors=", colors

IO.puts "\nMap with many types of keys"
Dump.inspect "  ", %{"one" => 1, :two => 2, {1, 1, 1} => 3}

IO.puts "\nMap indexing using existing and non-existing keys:"
Dump.inspect ~s(  states["AL"]=), states["AL"]
Dump.inspect ~s(  states["TX"]=), states["TX"]
Dump.inspect(~s|  response_types[{:error, :enoent}]=|,
							response_types[{:error, :enoent}])
IO.puts "\nKeyword keys also support dot notation:"
Dump.inspect ~s(  colors[:red]=), colors[:red]
Dump.inspect ~s(  colors.green=), colors.green

IO.puts "\nMisspell a key with dot notation and raise KeyError."
try do
	IO.puts "colors.blau"
	colors.blau
rescue
	e ->
		IO.inspect e
end

# Binaries.
IO.puts "\nBinaries:"
bin = <<1, 2>>
Dump.inspect "bin=", bin
Dump.inspect "byte_size bin=", byte_size bin

IO.puts "Binaries with sizes"
bin = <<3::size(2), 5::size(4), 1::size(2)>>
Dump.inspect("<<3::size(2), 5::size(4), 1::size(2)>>=", bin)

:io.format("bin=~-8.2b~n", :binary.bin_to_list(bin))
Dump.puts("size bin=", size bin)