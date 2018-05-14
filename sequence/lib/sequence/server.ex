defmodule Sequence.Server do
  @moduledoc """
  Our first GenServer.
"""

  use GenServer

  #####
  # External API
  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  #####
  # GenServer implementation

  def init(starting_at) do
    {:ok, starting_at}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

#  def handle_cast(_msg, state) do
#    {:noreply, state}
#  end

  def handle_cast({:increment_number, by}, current_number) do
    {:noreply, current_number + by}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy."}]]
  end
end