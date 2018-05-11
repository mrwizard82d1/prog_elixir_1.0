defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1, sort_into_descending_order: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["incredulitas", "credent", "26"]) == {"incredulitas", "credent", 26}
  end

  test "count is defaulted if two values given" do
    assert parse_args(["misceo", "linquo"]) == {"misceo", "linquo", 4}
  end

  test "sort descending orders correctly" do
    result = sort_into_descending_order(fake_created_at_list(["c", "b", "a"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w(c b a)
  end

  def fake_created_at_list(values) do
    for value <- values, do: %{"created_at" => value, "other_data" => "reducis"}
  end
end