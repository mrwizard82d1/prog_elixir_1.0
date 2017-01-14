IO.puts "# A (flat) list"
IO.puts '> ["Humperdinck", "Buttercup", "Fezzik"]'
["Humperdinck", "Buttercup", "Fezzik"]

IO.write "\n"
IO.puts "# Another (nested) list"
IO.puts '> ["milk", "butter", ["iocane", 12]]'
["milk", "butter", ["iocane", 12]]

IO.write "\n"
IO.puts "# Matching a whole list"
IO.puts "list = [1, 2, 3]"
list = [1, 2, 3]
IO.inspect list

IO.write "\n"
IO.puts "Matching items in a list (destructuring)"
list = [1, 2, 3]
IO.inspect "> [a b, c] = list"
[a, b, c] = list
IO.puts "> a"
IO.puts a
IO.puts "> b"
IO.puts b
IO.puts "> c"
IO.puts c
