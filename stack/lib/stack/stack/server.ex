defmodule Stack.Server do
  @moduledoc """
  A stack (server)
"""
  
#

  use GenServer

  def start_link(contents) do
    GenServer.start_link(__MODULE__, contents)
  end

  def init(contents) do
    {:ok, contents}
  end

#  def handle_call(_msg, _from, contents) do
#    {:reply, :ok, contents}
#  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

#  def handle_cast(_msg, contents) do
#    {:noreply, contents}
#  end
end