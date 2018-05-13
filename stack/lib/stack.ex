defmodule Stack do
  @moduledoc """
  API for a Stack (GenServer).
  """

  @server Stack.Server

  def start_link(contents) do
    GenServer.start_link(@server, contents, name: @server)
  end

  def pop, do: GenServer.call(@server, :pop)

  def push(item) do
    GenServer.cast(@server, {:push, item})
  end
end
