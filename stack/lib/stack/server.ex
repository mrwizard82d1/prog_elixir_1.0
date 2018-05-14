defmodule Stack.Server do
  @moduledoc false
  


  use GenServer

  #####
  # API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop, do: GenServer.call(__MODULE__, :pop)

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  #####
  # GenServer implementation

  def init(_) do
    {:ok, Stack.Stash.get()}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, head}, tail) do
    {:noreply, [head | tail]}
  end

  def terminate(_reason, contents) do
    Stack.Stash.update(contents)
  end
end