defmodule CliTest do
  use ExUnit.Case

	import Issues.CLI, only: [parse_args: 1]

	test ":help returned if CLI arguments contains -h" do
		assert parse_args(["anything", "-h"]) == :help
	end

	test ":help returned if CLI arguments contains --help" do
		assert parse_args(["anything", "--help"]) == :help
	end

	test "Returns three values if three values given." do
		assert(parse_args(["lorem", "ipsum", "99"]) ==
						 {"lorem", "ipsum", 99})
	end

	test "Used default count if no count given." do
		assert(parse_args(["lorem", "ipsum"]) ==
						 {"lorem", "ipsum", 4})
	end

end
