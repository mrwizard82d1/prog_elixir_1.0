defmodule Issues.CLI do

	# Default number of issues to retrieve from GitHib.
	@default_count 4

	@moduledoc """
  Handle command line parsing and dispatch to the various functions
  that generate a table of the last _n_ issues in a GitHub project.
  """

	def run(argv) do
		argv
		|> parse_args()
		|> process()
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

	@doc """
  Process the request made by the user.

  If the request was for help, display a help message and exit the
  application. If the request was for GitHub project issues, query
  GitHub, format the issues and display the requested issues.
  """
	def process(:help) do
		IO.puts("""

    Retrieve issues from a GitHub project.

    usage: issues <user> <project> [count( = #{@default_count})]. 
    """)

		# Halt the system with an exit code of 0.
		System.halt(0)
	end
	def process({user, project, _count}) do
		Issues.GitHub.fetch(user, project)
	end

end
