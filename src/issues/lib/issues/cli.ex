defmodule Issues.CLI do

	# Default number of issues to retrieve from GitHib.
	@default_count 4

	@moduledoc """
  Handle command line parsing and dispatch to the various functions
  that generate a table of the last _n_ issues in a GitHub project.
  """

	def run(argv) do
		parse_args(argv)
	end
	
  @doc """
  `argv` can be -h or --help which returns :help. Otherwise, it
	contains the GitHub user name, the project name, and, optionally,
  the number of entries to format.

  Returns a tuple of `{user, project, count}` unless help was
  requested. If help was requested, returns `:help`.
  """
	def parse_args(argv) do
		# Parse the vector looking for help which has a boolean value.
		parse = OptionParser.parse(argv, switches: [:help, :boolean],
															 aliases: [h: :help]) 

		case parse do
			{[help: true], _, _} ->
				:help
			{_, [user, project, count], _} ->
				{user, project, String.to_integer(count)}
			{_, [user, project], _} -> 
				{user, project, @default_count}
			_ ->
				:help
		end
	end

end
