defmodule Issues.GithubIssues do
  @user_agent [{"user-agent", "Elixir mrwizard82d1@gmail.com"}]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    result = "https://api.github.com/repos/#{user}/#{project}/issues"
    IO.puts "Fetching from #{result}"
    result
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end
  def handle_response({_, %{status_code: status_code, body: body}}) do
    {:error, status_code, body}
  end
end