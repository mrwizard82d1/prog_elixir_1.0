defmodule Stack.Stash do
  @moduledoc false

  use GenServer

  @me __MODULE__

  #####
  # API

  def start_link(initial_contents) do
    GenServer.start_link(__MODULE__, initial_contents, name: @me)
  end

  def get, do: GenServer.call(@me, {:get})

  def update(new_contents) do
    GenServer.cast(@me, {:update, new_contents})
  end

  #####
  # GenServer implementation

  def init(initial_contents) do
    {:ok, initial_contents}
  end

  def handle_call({:get}, _from, current_contents) do
    {:reply, current_contents, current_contents}
  end

  def handle_cast({:update, new_contents}, _current_contents) do
    {:noreply, new_contents}
  end
end