defmodule Helper do
  def comment(text) do
    IO.puts "# #{text}"
  end

  def read(expr) do
    IO.puts "> #{expr}"
  end

  def blank_line() do
    IO.write "\n"
  end

  def print(list) do
    IO.inspect list
  end
end

Helper.comment "A (flat) list"
Helper.read '["Humperdinck", "Buttercup", "Fezzik"]'
Helper.print ["Humperdinck", "Buttercup", "Fezzik"]

Helper.blank_line
Helper.comment "Another (nested) list"
Helper.read '["milk", "butter", ["iocane", 12]]'
Helper.print ["milk", "butter", ["iocane", 12]]

Helper.blank_line
Helper.comment "Matching a whole list"
Helper.read "list = [1, 2, 3]"
list = [1, 2, 3]
Helper.print list

Helper.blank_line
Helper.comment "Matching items in a list (destructuring)"
Helper.read "list = [1, 2, 3]"
list = [1, 2, 3]
Helper.read "[a b, c] = list"
[a, b, c] = list
Helper.read "a"
Helper.print a
Helper.read "b"
Helper.print b
Helper.read "c"
Helper.print c

Helper.blank_line
Helper.comment "Matching a nested list"
Helper.read "list = [1, 2, [3, 4, 5]]"
list = [1, 2, [3, 4, 5]]
Helper.print list
Helper.read "[a, b, c] = list"
[a, b, c] = list
Helper.print list
Helper.comment "a and b are scalar value"
Helper.read "a"
Helper.print a
Helper.read "b"
Helper.print b
Helper.comment "But c matches an entire list"
Helper.read "c"
Helper.print c

Helper.blank_line
Helper.comment "Matching a list with literal values"
Helper.read "list = [1, 2, 3]"
list = [1, 2, 3]
Helper.print list
Helper.read "[a, 2, b] = list"
[a, 2, b] = list
Helper.comment "The match succeeds because both lists have a 2 as the second item"
Helper.read "a"
Helper.print a
Helper.read "b"
Helper.print b

Helper.blank_line
Helper.comment "But if literals **do not** match, the match **fails**"
Helper.read "list = [1, 2, 3]"
list = [1, 2, 3]
Helper.print list
Helper.read "[a, 1, b] = list"
[a, 1, b] = list
