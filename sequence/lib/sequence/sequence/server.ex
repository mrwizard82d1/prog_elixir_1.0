defmodule Sequence.Server do
  @moduledoc """
  Our first GenServer.
"""

  use GenServer

#  def start_link(state, opts) do
#    GenServer.start_link(__MODULE__, state, opts)
#  end

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
end