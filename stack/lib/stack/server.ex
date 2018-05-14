defmodule Stack.Server do
  @moduledoc false
  


  use GenServer

  #####
  # API

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def pop, do: GenServer.call(__MODULE__, :pop)

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  #####
  # GenServer implementation

  def init(state) do
    {:ok, state}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, head}, tail) do
    {:noreply, [head | tail]}
  end
end