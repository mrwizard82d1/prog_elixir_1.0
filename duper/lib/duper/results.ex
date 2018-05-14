defmodule Duper.Results do
  @moduledoc false

  use GenServer

  @me __MODULE__

  # API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def add_hash_for(path, hash) do
    GenServer.cast(@me, {:add, path, hash})
  end

  def find_duplicates(), do: GenServer.call(@me, :find_duplicates)

  # Server

  def init(:no_args) do
    {:ok, %{}}
  end

  def handle_call(:find_duplicates, _from, results) do
    {:reply, hashes_with_more_than_one_path(results), results}
  end

  def hashes_with_more_than_one_path(results) do
    results
    |> Enum.filter(fn {_hash, paths} -> length(paths) > 1 end)
    |> Enum.map(&elem(&1, 1))
  end

  def handle_cast({:add, path, hash}, results) do
    results = Map.update(results, # look in this map ...
      hash, # ... for this key
      [path], # if not found, return this value
      # otherwise execute this function
      fn existing -> [path | existing] end)
    {:noreply, results}
  end
end