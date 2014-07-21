handle_open = fn
								{:ok, file} ->
									"First line: #{IO.read(file, :line)}"
								{_, error} ->
									"Error: #{:file.format_error(error)}"
							end
IO.puts "Calling handle_open() with an existing file."
IO.puts handle_open.(File.open("src/intro/hello.exs"))

IO.puts "Calling handle_open() with a non-existant file."
IO.puts handle_open.(File.open("non-existant-file"))