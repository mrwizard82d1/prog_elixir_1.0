defmodule Libraries do
	def float_to_string(to_convert) do
		:io_lib.format("~.2f", [to_convert])
	end

	def get_env(var_name) do
		System.get_env(var_name)
	end

	def get_ext(path) do
		Path.extname(path)
	end

	def get_cwd() do
		System.cwd()
	end

	def system(cmd) do
		System.cmd(cmd, [""])
	end
end

require Dump

IO.puts("\nConvert float to string.")
Dump.puts("Libraries.float_to_string(3.1) -> ",
					Libraries.float_to_string(3.1))
Dump.puts("Libraries.float_to_string(3.14) -> ",
					Libraries.float_to_string(3.14))
Dump.puts("Libraries.float_to_string(3.145) -> ",
					Libraries.float_to_string(3.145))

IO.puts("\nQuery environment variables.")
Dump.puts("Libraries.get_env(\"HOME\") -> ",
					Libraries.get_env("HOME"))
Dump.puts("Libraries.get_env(\"HOM\") -> ",
					Libraries.get_env("HOM"))

IO.puts("\nGet path extension.")
Dump.puts("Libraries.get_ext(\"dave\test.exs\") -> ",
					Libraries.get_ext("dave\test.exs"))
Dump.puts("Libraries.get_ext(\"test\") -> ",
					Libraries.get_ext("test"))

IO.puts("\nGet current working directory.")
Dump.puts("Libraries.get_cwd() -> ", 
					Libraries.get_cwd())

IO.puts("\nExecute date")
# Dump.puts("Libraries.system(\"date\") -> ", Libraries.system("date")) 